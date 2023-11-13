import 'package:flutter/material.dart';

class EcoButton extends StatelessWidget {
  String? title;
  bool? isLoginButton;
  Function()? onPress;
  bool isLoading;
  EcoButton(
      {super.key,
      this.title,
      this.isLoading = false,
      this.isLoginButton = false,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isLoginButton == true ? Colors.black : Colors.white,
          border: Border.all(
              color: isLoginButton == true ? Colors.white : Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Visibility(
              visible: isLoading ? false : true,
              child: Center(
                  child: Text(
                title ?? "button",
                style: TextStyle(
                    color: isLoginButton == true ? Colors.white : Colors.black,
                    fontSize: 16),
              )),
            ),
            Visibility(
              visible: isLoading,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
