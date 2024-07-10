import 'package:app/screens/signup/signup.dart';
import 'package:app/services/authservices.dart';
import 'package:app/helper/validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> _authData = {};
  final FocusNode _focusNode = FocusNode();
  bool isLoading = false;

  changeLodingState(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign In",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    custTextField(
                      hint: "Email",
                      onSaved: (email) => _authData["email"] = email!,
                      validator: Validator.emailValidator,
                    ),
                    custTextField(
                      hint: "Password",
                      focusNode: _focusNode,
                      obscureText: true,
                      onSaved: (pass) => _authData["pass"] = pass!,
                      validator: Validator.passValidator,
                    ),
                    isLoading
                        ? const SizedBox(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                onPressed: () async {
                                  _focusNode.unfocus();
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    changeLodingState(true);
                                    _formKey.currentState?.save();
                                    await AuthServices().signIn(
                                        _authData["email"]!,
                                        _authData["pass"]!,
                                        context);
                                    changeLodingState(false);
                                  }
                                },
                                child: const Text("Sign In")),
                          ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Signup(),
                              ));
                        },
                        child: const Text("Create an Account"))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

Widget custTextField({
  required String hint,
  TextEditingController? controller,
  FocusNode? focusNode,
  bool? obscureText,
  void Function(String?)? onSaved,
  String? Function(String?)? validator,
}) {
  return Column(
    children: [
      TextFormField(
        onSaved: onSaved,
        validator: validator,
        focusNode: focusNode,
        controller: controller,
        obscureText: obscureText ?? false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue)),
            hintText: hint),
      ),
      const SizedBox(
        height: 20,
      )
    ],
  );
}

Future<void> signIn(String email, String pass) async {
  final auth = FirebaseAuth.instance;
  auth.signInWithEmailAndPassword(email: email, password: pass);
}

Future<void> signUp(
    String email, String pass, String username, BuildContext ctx) async {
  final auth = FirebaseAuth.instance;
  UserCredential user =
      await auth.createUserWithEmailAndPassword(email: email, password: pass);

  print(user);
}
