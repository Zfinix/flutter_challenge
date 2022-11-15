import 'package:flutter_challenge/core/utils/extensions.dart';

class Validator {
  final reverseDict = '9876543210';
  final dict = '0123456789';

  bool validName(String value) {
    final lowerCase = value.toLowerCase().split('');
    final charArr = r"±§@£€#$%^&**!()_+=`~,.<>/?;:'|'][{}1234567890".split('');

    if (value.contains(RegExp(r'\s+'))) {
      return false;
    }

    if (lowerCase.containsAny(charArr)) {
      return false;
    }

    return true;
  }

  bool isEmail(String em) {
    const p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  bool hasMin2chars(String em) {
    final hasMin8chars = em.length >= 2;
    return hasMin8chars;
  }

  bool containSpecialChars(String em) {
    final hasSpecialCharacters = RegExp(r'[!@#$%^&*()?":{}|<>]');
    return hasSpecialCharacters.hasMatch(em);
  }

  bool containsASequence(String str) {
    return dict.contains(str) || reverseDict.contains(str);
  }

  bool containsDuplicates(String str) {
    return str.split('').containsDuplicates;
  }
}
