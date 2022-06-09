import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/model_auth.dart';
import 'package:flutter_shopping_mall/tabs/tab_cart.dart';
import 'package:flutter_shopping_mall/tabs/tab_home.dart';
import 'package:flutter_shopping_mall/tabs/tab_profile.dart';
import 'package:flutter_shopping_mall/tabs/tab_search.dart';
import 'package:provider/provider.dart';

class IndexScreen extends StatefulWidget {

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    HomeTab(),
    SearchTab(),
    CartTab(),
    ProfileTab()
  ];
  @override
  Widget build(BuildContext context) {
    final authClient = Provider.of<FirebaseAuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            child: Container(
              padding: EdgeInsets.fromLTRB(0,0,15,0),
              child: Icon(Icons.logout),
            ),onTap: () async{
              await authClient.logout();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text('로그아웃 되었습니다.')));
                Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.search),label: '검색'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: '장바구니'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: '프로필'),
        ],
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontSize: 12),
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },),
        body: _tabs[_currentIndex],
    );
  }
}