import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/model_item.dart';

class CartProvider with ChangeNotifier {
  late CollectionReference cartReferece;
  List<Item> cartItems = [];

  CartProvider({reference}) {
    cartReferece = reference ?? FirebaseFirestore.instance.collection('cart');
  }

  Future<void> fetchCartItemsOrAddCart(User? user) async {
    if (user == null) {
      return;
    }
    final cartSnapshot = await cartReferece.doc(user.uid).get();
    if (cartSnapshot.exists) {
      Map<String, dynamic> cartItemsMap =
          cartSnapshot.data() as Map<String, dynamic>;
      List<Item> temp = [];
      for (var item in cartItemsMap['items']) {
        temp.add(Item.fromSnapshot(item));
      }
      cartItems = temp;
      notifyListeners();
    } else {
      await cartReferece.doc(user.uid).set({'items': []});
      notifyListeners();
    }
  }

  Future<void> addItemToCart(User? user, Item item) async {
    cartItems.add(item);
    print(cartItems);
    Map<String, dynamic> cartItemsMap = {
      'items': cartItems.map((item) {
        return item.toSnapshot();
      }).toList()
    };
    print(cartItemsMap);
    await cartReferece.doc(user!.uid).set(cartItemsMap);
    notifyListeners();
  }

  Future<void> removeItemFromCart(User? user, Item item) async {
    cartItems.removeWhere((element) => element.id == item.id);
    Map<String, dynamic> cartItemsMap = {
      'items': cartItems.map((item) {
        return item.toSnapshot();
      }).toList()
    };
    await cartReferece.doc(user!.uid).set(cartItemsMap);
    notifyListeners();
  }

  bool isItemIncart(Item item) {
    return cartItems.any((element) => element.id == item.id);
  }
}
