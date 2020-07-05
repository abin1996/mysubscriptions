class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String email) {
    if (email.length > 0) {
      return _emailRegExp.hasMatch(email);
    }
    return true;
  }

  static isValidPassword(String password) {
    if (password.length > 0) {
      return _passwordRegExp.hasMatch(password);
    }
    return true;
  }
}
