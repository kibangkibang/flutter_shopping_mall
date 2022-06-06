import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/screens/screen_index.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shopping Mall',
      routes: {
        '/index':(context) => IndexScreen(),
      },
      initialRoute: '/index',
    );
  }
}