import 'package:flutter_challenge/l10n/l10n.dart';
import 'package:mocktail/mocktail.dart';

class MockAppLocalizations extends Mock implements AppLocalizations {}

class Mockl10n {
  static String nameLengthError = 'nameLengthError';
  static String nameValidError = 'nameValidError';
  static String emailValidError = 'emailValidError';
  static String passcodeLengthError = 'passcodeLengthError';
  static String passcodeDuplicateDigitsError = 'passcodeDuplicateDigitsError';
  static String passcodeSequentialDigitsError = 'passcodeSequentialDigitsError';
}
