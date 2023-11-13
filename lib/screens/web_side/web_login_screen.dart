import 'dart:io';

import 'package:eco_buy/screens/web_side/web_main_screen.dart';
import 'package:eco_buy/services/firebase_services.dart';
import 'package:eco_buy/utils/styles.dart';
import 'package:eco_buy/widgets/eco_button.dart';
import 'package:eco_buy/widgets/eco_dialogue.dart';
import 'package:eco_buy/widgets/ecotextfeild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class WebLoginScreen extends StatefulWidget {
  static const String id = "weblogin";

  @override
  State<WebLoginScreen> createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends State<WebLoginScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController userC = TextEditingController();
  TextEditingController pwdC = TextEditingController();
  bool formStateLoading = false;

  onSubmit(BuildContext, context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });
      await FirebaseServices.adminLogin(userC.text).then((value) async {
        if (value['username'] == userC.text && value['password'] == pwdC.text) {
          try {
            UserCredential user =
                await FirebaseAuth.instance.signInAnonymously();
            if (user != null) {
              Navigator.pushReplacementNamed(context, WebAdminScreen.id);
            }
          } catch (e) {
            setState(() {
              formStateLoading = false;
            });
            showDialog(
                context: context,
                builder: (_) {
                  return EcoDialog(
                    title: e.toString(),
                  );
                });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Center(
                    child: Text(
                      "Wecome Admin",
                      style: EcoStyle.kBoldStyle,
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Login to your account",
                      style: EcoStyle.kBoldStyle,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  EcoField(
                    isFilledColor: true,
                    filledColor: Colors.grey.withOpacity(0.2),
                    controller: userC,
                    hintText: 'Enter User id',
                    validate: (p0) {
                      if (p0!.isEmpty) {
                        return "enter user id";
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  EcoField(
                    isFilledColor: true,
                    filledColor: Colors.grey.withOpacity(0.2),
                    controller: pwdC,
                    pass: true,
                    hintText: 'Enter password',
                    validate: (p0) {
                      if (p0!.isEmpty) {
                        return "password should not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  EcoButton(
                    isLoading: formStateLoading,
                    onPress: () => onSubmit(BuildContext, context),
                    title: 'Submit',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
