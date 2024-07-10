class Validator {
  static String? userNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is Required';
    } else if (value.length < 5) {
      return 'Minimun 5 chars required';
    } else if (value.length > 20) {
      return 'Maximum 20 chars';
    } else {
      return null;
    }
  }

  // email validator

  static String? emailValidator(value) {
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (value.isEmpty || value == null) {
      return 'Email is Required';
    } else if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

// password validator
  static String? passValidator(value, {bool loginPass = false}) {
    if (value.isEmpty || value == null) {
      return 'Password is Required';
    } else if (value.length < 6 && !loginPass) {
      return 'Password should contain min 6 chars';
    } else if (value.length < 6) {
      return 'Enter Valid Password';
    } else {
      return null;
    }
  }
}
