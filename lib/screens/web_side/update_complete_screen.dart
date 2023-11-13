import 'package:eco_buy/models/productsModel.dart';
import 'package:flutter/material.dart';

class UpdateCompleteScreen extends StatelessWidget {
  Products? products;
  String? id;
  String? index;
  UpdateCompleteScreen({super.key, this.products, this.id, this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Complete Update List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              id.toString(),
              style: TextStyle(fontSize: 25),
            ),
            Text(
              products!.productName ?? '',
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
