import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/model_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> checkLogin() async{
    final authClient = Provider.of<FirebaseAuthProvider>(listen: false,context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    print('[*] 로그인 상태 : ' + isLogin.toString());
    if(isLogin){
      String? email = prefs.getString('email');
      String? password = prefs.getString('password');
      await authClient.loginWithEmail(email!, password!).then((status){
        if(status == AuthStatus.loginSuccess){
          print('[+] 로그인성공');
        }else{
          print('[-] 로그인실패');
          isLogin = false;
          prefs.setBool('isLogin', isLogin);
        }
      });
    }
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/logo.png'),
          Padding(padding: EdgeInsets.all(25)),
          CircularProgressIndicator(color: Colors.black26),
        ],
      )),
    );
  }
}