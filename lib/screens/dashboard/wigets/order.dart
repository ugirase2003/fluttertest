import 'package:flutter/material.dart';

class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Center(
            child: Text(
          "Order Page",
          style: Theme.of(context).textTheme.headlineMedium,
        )),
      ),
    );
  }
}
