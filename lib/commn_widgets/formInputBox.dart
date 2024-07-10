import 'package:flutter/material.dart';

class FormInputBox extends StatelessWidget {
  FormInputBox(
      {Key? key,
      required this.hint,
      this.focusNode,
      this.validator,
      this.controller,
      this.obscureText,
      this.onSaved})
      : super(key: key);
  TextEditingController? controller;
  FocusNode? focusNode;
  String hint;
  bool? obscureText;
  void Function(String?)? onSaved;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
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
}
