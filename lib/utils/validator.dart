/// Validators for various validations in the app for input fields
class Validator {
  const Validator._();

  /// Checks if the passed value is null or empty
  static String? isEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Field cannot be empty";
    }
    return null;
  }

  /// Checks if the email is valid
  static String? isEmailValid(String? value) {
    String? res = isEmpty(value);
    if (res != null) return res;

    /*
     The regex was directly copied from https://stackoverflow.com/a/50663835/13798721

     May simplify it according to the requirements.
     */
    bool hasMatch = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);
    if (!hasMatch) {
      return "Invalid email";
    }
    return null;
  }

  /// Simple password validator where the minimum length is 6.
  static String? isPasswordValid(String? value) {
    String? res = isEmpty(value);
    if (res != null) return res;

    if (value!.length < 6) {
      return "Password must be at least 6 characters.";
    }
    return null;
  }
}
