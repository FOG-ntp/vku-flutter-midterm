import 'package:eco_buy/screens/mobile_side.dart/homeScreen.dart';
import 'package:eco_buy/screens/mobile_side.dart/signup_screen.dart';
import 'package:eco_buy/services/firebase_services.dart';
import 'package:eco_buy/utils/styles.dart';
import 'package:eco_buy/widgets/eco_button.dart';
import 'package:eco_buy/widgets/ecotextfeild.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  final formkey = GlobalKey<FormState>();

  bool formStateLoading = false;

  @override
  Widget build(BuildContext context) {
    Future<void> ecoDialogue(String error) async {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Center(
                child: Text(
                  error,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              actions: [
                EcoButton(
                  title: 'CLOSE',
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }

    submit() async {
      if (formkey.currentState!.validate()) {
        setState(() {
          formStateLoading = true;
        });

        String? accountStatus =
            await FirebaseServices.signInAccount(emailC.text, passwordC.text);
        if (accountStatus == null) {
          setState(() {
            formStateLoading = false;
          });
        }

        if (accountStatus != null) {
          ecoDialogue(accountStatus);
          setState(() {
            formStateLoading = false;
          });
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 0),
              const Text(
                'WELCOME, \n please login first',
                style: EcoStyle.kBoldStyle,
                textAlign: TextAlign.center,
              ),
              Column(
                children: [
                  Form(
                    key: formkey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          EcoField(
                            isFilledColor: true,
                            filledColor: Colors.grey.withOpacity(0.2),
                            controller: emailC,
                            hintText: 'Enter Email',
                            validate: (p0) {
                              if (p0!.isEmpty ||
                                  !p0.contains("@") ||
                                  !p0.contains(".com")) {
                                return "email formatted badly";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          EcoField(
                            isFilledColor: true,
                            filledColor: Colors.grey.withOpacity(0.2),
                            controller: passwordC,
                            pass: true,
                            hintText: 'Enter password',
                            validate: (p0) {
                              if (p0!.isEmpty) {
                                return "password should not be empty";
                              }
                              return null;
                            },
                          ),
                          EcoButton(
                            title: "LOGIN",
                            isLoginButton: true,
                            isLoading: formStateLoading,
                            onPress: () {
                              submit();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: EcoButton(
                  title: "CREATE NEW ACCOUNT",
                  isLoginButton: false,
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupScreen(),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
