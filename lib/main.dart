import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/screens/screen_index.dart';
import 'package:flutter_shopping_mall/screens/screen_login.dart';
import 'package:flutter_shopping_mall/screens/screen_splash.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shopping Mall',
      routes: {
        '/':(context) => SplashScreen(),
        '/index':(context) => IndexScreen(),
        '/login':(context) => LoginScreen(),
      },
      initialRoute: '/',
    );
  }
}