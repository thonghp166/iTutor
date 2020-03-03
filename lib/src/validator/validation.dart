class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static final RegExp _phoneRegExp = RegExp(
    r'^(?:[+0]9)?[0-9]{10,11}$',
  );

  static bool isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    print("validating pass");
    return _passwordRegExp.hasMatch(password);
  }

  static bool isValidRePassword(String password,String rePass) {
    return _passwordRegExp.hasMatch(rePass) && password == rePass;
  }


  static bool isValidPhone(String phone) {
    return _phoneRegExp.hasMatch(phone);
  }
}