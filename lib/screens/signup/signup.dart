import 'package:app/screens/signin/signin.dart';
import 'package:app/services/authservices.dart';
import 'package:app/helper/validator.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  late final Map<String, String> _authData;
  final FocusNode _focusNode = FocusNode();
  late final TextEditingController _passController;
  bool isLoading = false;
  bool? _termsAccepted;
  @override
  void initState() {
    _termsAccepted = false;
    _passController = TextEditingController();
    _authData = {};
    super.initState();
  }

  @override
  void dispose() {
    _passController.dispose();
    super.dispose();
  }

  // login fun
  // autoLogin() async {
  //   final SharedPreferences sp = await SharedPreferences.getInstance();
  //   if (sp.getBool("loggedin") ?? false) {
  //     // if loggedin is true then userId can't be null
  //     int userId = sp.getInt("userId")!;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign Up",
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
                      hint: "Username",
                      onSaved: (email) => _authData["username"] = email!,
                      validator: Validator.userNameValidator,
                    ),
                    custTextField(
                      hint: "Email",
                      onSaved: (email) => _authData["email"] = email!,
                      validator: Validator.emailValidator,
                    ),
                    custTextField(
                      hint: "Password",
                      controller: _passController,
                      obscureText: true,
                      onSaved: (pass) => _authData["pass"] = pass!,
                      validator: Validator.passValidator,
                    ),
                    custTextField(
                      hint: "Confirm Password",
                      obscureText: true,
                      focusNode: _focusNode,
                      validator: (pass) => _passController.text == pass &&
                              (pass != null && pass.isNotEmpty)
                          ? null
                          : "Password doesn't match",
                    ),
                    CheckboxListTile(
                      value: _termsAccepted,
                      title: const Text("I accept all terms and conitions"),
                      onChanged: (value) => setState(() {
                        _termsAccepted = value;
                      }),
                    ),
                    isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                onPressed: () async {
                                  _focusNode.unfocus();
                                  if (_termsAccepted == false) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                                "Please accept terms and conditions")));
                                  }
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    _formKey.currentState?.save();
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await AuthServices().signUp(
                                        _authData["email"]!,
                                        _authData["pass"]!,
                                        _authData["username"]!,
                                        context);
                                  }
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                child: const Text("Sign up")),
                          ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Forgot Password",
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ));
                        },
                        child: const Text("Sign In"))
                  ],
                ))
          ],
        ),
      ),
    ));
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
