import 'package:eco_buy/screens/mobile_side.dart/homeScreen.dart';
import 'package:eco_buy/screens/mobile_side.dart/login_screen.dart';
import 'package:eco_buy/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});
  Future<FirebaseApp> initilize = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initilize,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('${snapshot.error}')),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
              //this line checks wheather we are loggen in ir not
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot streamSnapshot) {
                if (streamSnapshot.hasError) {
                  return Scaffold(
                    body: Center(child: Text('${streamSnapshot.error}')),
                  );
                }
                if (streamSnapshot.connectionState == ConnectionState.active) {
                  User? user = streamSnapshot.data;
                  if (user == null) {
                    return LoginScreen();
                  } else {
                    return const HomeScreen();
                  }
                }
                return const Scaffold(
                  body: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CHECKING\nAUTHENTICATION . . . ',
                        style: EcoStyle.kBoldStyle,
                      ),
                      CircularProgressIndicator()
                    ],
                  )),
                );
              });
        }

        return const Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'INITIALIZATION. . . .',
                style: EcoStyle.kBoldStyle,
              ),
              CircularProgressIndicator()
            ],
          )),
        );
      },
    );
  }
}
