import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/model_item.dart';

class ItemProvider extends ChangeNotifier{
  late CollectionReference itemsReference;
  List<Item> items = [];

  ItemProvider({reference}) : itemsReference = reference ?? FirebaseFirestore.instance.collection('items');

  Future<void> fetchItems() async{
    items = await itemsReference.get().then((QuerySnapshot results){
      return results.docs.map((DocumentSnapshot document) {
        return Item.fromSnapshot(document);
      },).toList();
    });
    notifyListeners();
  }
}
