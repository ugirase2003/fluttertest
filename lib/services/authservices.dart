import 'package:app/screens/dashboard/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  final auth = FirebaseAuth.instance;

  Future<void> signUp(
      String email, String pass, String username, BuildContext context) async {
    try {
      final UserCredential userCred = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);

      FirebaseFirestore db = FirebaseFirestore.instance;
      db
          .collection("users")
          .doc(userCred.user?.uid)
          .set({"username": username, "email": email}).whenComplete(
              () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Dashboard(),
                  )));
    } catch (e) {
      context.mounted
          ? ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error Occured $e")))
          : null;
    }
  }

  Future<void> signIn(String email, String pass, BuildContext context) async {
    try {
      final UserCredential userCred =
          await auth.signInWithEmailAndPassword(email: email, password: pass);

      FirebaseFirestore db = FirebaseFirestore.instance;
      DocumentSnapshot userData =
          await db.collection("users").doc(userCred.user?.uid).get();
      String username = userData["username"];
      String useremail = userData["email"];
      // we can store this data in shared prefernces as well
    } catch (e) {
      context.mounted
          ? ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error Occured $e")))
          : null;
    }
  }

  Future<Map<String, String>> getUserData() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentSnapshot userData = await db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    String username = userData["username"];
    String useremail = userData["email"];

    return {"username": username, "useremail": useremail};
  }
}
