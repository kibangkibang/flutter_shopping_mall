import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_shopping_mall/models/model_auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/screens/screen_detail.dart';
import 'package:flutter_shopping_mall/screens/screen_index.dart';
import 'package:flutter_shopping_mall/screens/screen_login.dart';
import 'package:flutter_shopping_mall/screens/screen_register.dart';
import 'package:flutter_shopping_mall/screens/screen_search.dart';
import 'package:flutter_shopping_mall/screens/screen_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FirebaseAuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Shopping Mall',
        routes: {
          '/': (context) => SplashScreen(),
          '/index': (context) => IndexScreen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/detail': (context) => DetailScreen(),
          '/search': (context) => SearchScreen(),
        },
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
      ),
    );
  }
}
