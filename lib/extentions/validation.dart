extension ExtString on String {
  //Landline validation
  bool get isValidLandline {
    final landLineRegex = RegExp(r'^[0-9]{8}$');
    return landLineRegex.hasMatch(this);
  }

//ID validation
  bool get isValidId {
    final landLineRegex = RegExp(r'^[0-9]{14}$');
    return landLineRegex.hasMatch(this);
  }

//Name validation
  bool get isValidName {
    final nameRegExp = RegExp('[a-zA-Z]');
    // RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }
}
