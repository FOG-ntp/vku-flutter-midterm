import 'package:eco_buy/screens/mobile_side.dart/landingPage.dart';
import 'package:eco_buy/screens/web_side/web_login_screen.dart';
import 'package:flutter/widgets.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.minWidth > 600) {
        return WebLoginScreen();
      } else {
        return LandingScreen();
      }
    });
  }
}
