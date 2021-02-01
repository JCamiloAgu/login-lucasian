class LoginFormValidator {
  bool isValidEmail(String email) {
    if (email == null || email.isEmpty || email.trim().length >= 60)
      return false;

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    var regExp = RegExp(pattern);
    return regExp.hasMatch(email) ? true : false;
  }

  bool isValidPassword(String password) {
    return password != null && password.isNotEmpty && password.length <= 15;
  }
}
