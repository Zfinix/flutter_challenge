import 'package:flutter_challenge/core/utils/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Validator validator;

  setUpAll(() {
    validator = Validator();
  });
  group('Validator', () {
    test(
        '.containsDuplicates(): digits should not repeat '
        'themselves more than 2 times', () {
      for (final value in [
        '265232',
        '344046',
        '668365',
        '477675',
        '588087',
        '611222',
        '776578',
      ]) {
        expect(validator.containsDuplicates(value), true);
      }
    });

    test('.containsASequence(): passcode should not be a simple sequence', () {
      for (final value in [
        '123456',
        '234567',
        '345678',
        '543210',
        '765432',
        '012345',
        '987654',
      ]) {
        expect(validator.containsASequence(value), true);
      }
    });

    test('.hasMin2chars(): should have more than 2 characters', () {
      expect(validator.hasMin2chars('t'), false);
      expect(validator.hasMin2chars('test'), true);
    });

    test('.containSpecialChars(): contains special characters', () {
      expect(validator.containSpecialChars('test'), false);
      expect(validator.containSpecialChars('!@#test'), true);
      expect(validator.containSpecialChars('!'), true);
      expect(validator.containSpecialChars('^&*()'), true);
      expect(validator.containSpecialChars(' '), false);
    });

    test('.isEmail(): is a valid email address', () {
      expect(validator.isEmail('test'), false);
      expect(validator.isEmail('t@test.com'), true);
      expect(validator.isEmail('t.com'), false);
      expect(validator.isEmail('test@test.net'), true);
      expect(validator.isEmail('test@gmail.live'), true);
    });

    test('.validName(): contains special characters', () {
      expect(validator.validName('test'), true);
      expect(validator.validName('t.com'), false);
      expect(validator.validName('!@#test'), false);
      expect(validator.validName('testuser'), true);
    });
  });
}
