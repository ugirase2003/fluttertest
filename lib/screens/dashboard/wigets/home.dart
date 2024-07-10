import 'package:app/screens/signin/signin.dart';
import 'package:app/services/authservices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SliverGridDelegateWithFixedCrossAxisCount
      _gridDelegateWithFixedCrossAxisCount;
  @override
  void initState() {
    _gridDelegateWithFixedCrossAxisCount =
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: FutureBuilder(
        future: AuthServices().getUserData(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${snapshot.data!["username"]}",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance
                                .signOut()
                                .whenComplete(() => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignIn(),
                                    )));
                          },
                          child: const Text("Logout")),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Horizontal List"),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        roundedImg("assets/images/food1.jpg"),
                        roundedImg("assets/images/food1.jpg"),
                        roundedImg("assets/images/food1.jpg"),
                        roundedImg("assets/images/food1.jpg"),
                        roundedImg("assets/images/food1.jpg"),
                        roundedImg("assets/images/food1.jpg"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Vertical List"),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.blueGrey,
                    child: Column(
                      children: [
                        roundedImg("assets/images/food1.jpg"),
                        const SizedBox(
                          height: 5,
                        ),
                        roundedImg("assets/images/food1.jpg"),
                        const SizedBox(
                          height: 5,
                        ),
                        roundedImg("assets/images/food1.jpg"),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  const Text("Grid View"),
                  Card(
                    color: Colors.white24,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: GridView(
                        shrinkWrap: true,
                        gridDelegate: _gridDelegateWithFixedCrossAxisCount,
                        children: [
                          roundedImg("assets/images/food1.jpg"),
                          roundedImg("assets/images/food1.jpg"),
                          roundedImg("assets/images/food1.jpg"),
                        ],
                      ),
                    ),
                  )
                ],
              )),
      ),
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
