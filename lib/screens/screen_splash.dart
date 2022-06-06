import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> checkLogin() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool isLogin = pref.getBool('isLogin') ?? false;
    return isLogin;
  }

  void moveScreen() async{
    await checkLogin().then((isLogin){
      if(isLogin){
        Navigator.of(context).pushReplacementNamed('/index');
      }else{
        Navigator.of(context).pushReplacementNamed('/login');
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 1500), () {
      moveScreen();
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/owl.png'),
          Padding(padding: EdgeInsets.all(25)),
          CircularProgressIndicator(color: Colors.black26),
        ],
      )),
    );
  }
}