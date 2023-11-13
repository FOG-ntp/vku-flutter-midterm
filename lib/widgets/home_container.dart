import 'package:eco_buy/utils/styles.dart';
import 'package:flutter/material.dart';

class HomeContainer extends StatelessWidget {
  final String? title;
  HomeContainer({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blueAccent.withOpacity(0.8),
                Colors.redAccent.withOpacity(0.8)
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Center(
                child: Text(
              title ?? 'Title',
              style: EcoStyle.kBoldStyle.copyWith(color: Colors.white),
            )),
          ),
        ),
      ),
    );
  }
}
