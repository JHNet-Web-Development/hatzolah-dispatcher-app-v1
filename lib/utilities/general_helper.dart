class Validators{
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)$',
  );

  static final RegExp _passwordRegExp = RegExp(
    r'^(((?=.[a-z])(?=.[A-Z]))|((?=.[a-z])(?=.[0-9]))|((?=.[A-Z])(?=.[0-9])))(?=.{6,})',
  );

  static final RegExp _simplePasswordRegExp = RegExp(
    r'^.{6,}$',
  );

  static isValidEmail(String email) {
    if (email != '') {
      return _emailRegExp.hasMatch(email);
    }

    return false;
  }

  static isValidPassword(String password, {bool simple = true}) {
    if (password != '') {
      if (simple) {
        return _simplePasswordRegExp.hasMatch(password);
      } else {
        return _passwordRegExp.hasMatch(password);
      }
    }

    return false;
  }
}