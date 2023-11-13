import 'package:eco_buy/services/firebase_services.dart';
import 'package:eco_buy/utils/styles.dart';
import 'package:eco_buy/widgets/eco_button.dart';
import 'package:eco_buy/widgets/ecotextfeild.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  TextEditingController retypePasswordC = TextEditingController();
  final formkey = GlobalKey<FormState>();

  FocusNode? passwordFocus;
  bool formStateLoading = false;
  //FocusNode? retypePasswordFocus;

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    retypePasswordC.dispose();
    super.dispose();
  }

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

        if (passwordC.text == retypePasswordC.text) {
          String? accountStatus =
              await FirebaseServices.createAccount(emailC.text, passwordC.text);
          if (accountStatus == null) {
            setState(() {
              formStateLoading = false;
            });
            ecoDialogue('SIGNUP SUCCESSFULL');
          }
          ecoDialogue(accountStatus.toString());
          if (accountStatus != null) {
            ecoDialogue(accountStatus);
            setState(() {
              formStateLoading = false;
            });
          } else {
            Navigator.pop(context);
          }

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (_) => LoginScreen()));
        } else {
          ecoDialogue('Not valid credentials');
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
                'WELCOME,\nplease Create Your Account',
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
                            pass: false,
                            hintText: 'Enter password',
                            validate: (p0) {
                              if (p0!.isEmpty) {
                                return "password should not be empty";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          EcoField(
                            isFilledColor: true,
                            filledColor: Colors.grey.withOpacity(0.2),
                            controller: retypePasswordC,
                            hintText: 'Retype password',
                            validate: (p0) {
                              if (p0!.isEmpty) {
                                return "password should not be empty";
                              }
                              return null;
                            },
                            pass: false,
                          ),
                          EcoButton(
                            onPress: () {
                              submit();
                            },
                            isLoading: formStateLoading,
                            title: "SIGNUP",
                            isLoginButton: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: EcoButton(
                  title: "BACK TO LOGIN",
                  isLoginButton: false,
                  onPress: () {
                    Navigator.pop(context);
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
// submit() async {
//     if (formkey.currentState!.validate()) {
//       setState(() {
//         formStateLoading = true;
//       });
//       if (passwordC.text == retypepasswordC.text) {
//         String? accountstatus =
//             await FirebaseServices.createAccount(emailC.text, passwordC.text);

//         //print(accountstatus);
//         if (accountstatus != null) {
//           ecoDialogue(accountstatus);
//           setState(() {
//             formStateLoading = false;
//           });
//         } else {!11
//           Navigator.pop(context);
//         }

//         //  Navigator.push(
//         //       context, MaterialPageRoute(builder: (_) => LoginScreen()));

//       }
//     }
//   }