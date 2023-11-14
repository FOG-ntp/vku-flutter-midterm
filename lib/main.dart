import 'package:eco_buy/screens/bottom_page.dart';
import 'package:eco_buy/screens/landing_screen.dart';
import 'package:eco_buy/screens/layout_screen.dart';
import 'package:eco_buy/screens/auth_screens/login_screen.dart';
import 'package:eco_buy/screens/web_side/addProducts_screen.dart';
import 'package:eco_buy/screens/web_side/dashboard_screen.dart';
import 'package:eco_buy/screens/web_side/deleteProducts_screen.dart';
import 'package:eco_buy/screens/web_side/updateProduct_screen.dart';
// import 'package:eco_buy/screens/web_side/update_complete_screen.dart';
import 'package:eco_buy/screens/web_side/web_login.dart';
import 'package:eco_buy/screens/web_side/web_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBJvZro8bvAkK7r6GdQbI63uEqN7p1gm2A",
            authDomain: "eco-buy-3f8ad.firebaseapp.com",
            projectId: "eco-buy-3f8ad",
            storageBucket: "eco-buy-3f8ad.appspot.com",
            messagingSenderId: "828526442301",
            appId: "1:828526442301:web:87eddd61cdb5bdb83ff754",
            measurementId: "G-V2HHQN8WV8"));
  } else {
    await Firebase.initializeApp();
  }
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        title: 'ECO FURNITURE',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: LayoutScreen(),
        routes: {
          WebLoginScreen.id: (context) => WebLoginScreen(),
          WebMainScreen.id: (context) => WebMainScreen(),
          AddProductScreen.id: (context) => AddProductScreen(),
          UpdateProductScreen.id: (context) => UpdateProductScreen(),
          DeleteProductScreen.id: (context) => DeleteProductScreen(),
          DashBoardScreen.id: (context) => DashBoardScreen(),
        },
      ),
    );
  }
}
