import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Center(
            child: Text(
          "Profile Page",
          style: Theme.of(context).textTheme.headlineMedium,
        )),
      ),
    );
  }
}
