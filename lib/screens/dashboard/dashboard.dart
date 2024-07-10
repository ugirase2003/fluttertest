import 'package:app/services/authservices.dart';
import 'package:app/screens/dashboard/wigets/home.dart';
import 'package:app/screens/dashboard/wigets/order.dart';
import 'package:app/screens/dashboard/wigets/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final pages = [const Home(), const Profile(), const Order()];
  int index = 0;
  chngPage(int index) {
    index != this.index
        ? setState(() {
            this.index = index;
          })
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Card(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  chngPage(0);
                },
                icon: const Icon(Icons.home),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    chngPage(1);
                  },
                  icon: const Icon(Icons.person)),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    chngPage(2);
                  },
                  icon: const Icon(Icons.food_bank))
            ],
          ),
        ),
      ),
      body: pages[index],
    );
  }
}

roundedImg(String path) {
  return Row(
    children: [
      ClipOval(
        child: Image.asset(
          path,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(
        width: 5,
      )
    ],
  );
}
