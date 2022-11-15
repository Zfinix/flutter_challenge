import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_challenge/auth/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mock_localization.dart';

//class _MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  group('AuthCubit', () {
    late AuthCubit authCubit;

    setUp(() {
      authCubit = AuthCubit(MockAppLocalizations());
    });

    test('.state: is [AuthStateInitial]', () {
      expect(authCubit.state, equals(isA<AuthStateInitial>()));
    });

    test('.updateName(): updates namestream', () {
      authCubit.nameStream.listen((event) {
        expect(event, 'text');
      });
    });

    test('.updateEmailAddress(): updates emailStream', () {
      authCubit.emailStream.listen((event) {
        expect(event, 'test@test.com');
      });
      authCubit.updateEmail('test@test.com');
    });

    test('.updatePasscode(): updates passcodeStream', () {
      authCubit.passcodeStream.listen((event) {
        expect(event, '839432');
      });
      authCubit.updatePasscode('839432');
    });
  });

  group('AuthCubit [blocTest]', () {
    late AuthCubit authCubit;

    setUp(() {
      authCubit = AuthCubit(MockAppLocalizations());
    });

    void setUpL10n() {
      when(() => authCubit.l10n.nameLengthError)
          .thenReturn(Mockl10n.nameLengthError);
      when(() => authCubit.l10n.nameValidError)
          .thenReturn(Mockl10n.nameValidError);
      when(() => authCubit.l10n.emailValidError)
          .thenReturn(Mockl10n.emailValidError);
      when(() => authCubit.l10n.passcodeLengthError)
          .thenReturn(Mockl10n.passcodeLengthError);
      when(
        () => authCubit.l10n.passcodeDuplicateDigitsError,
      ).thenReturn(Mockl10n.passcodeDuplicateDigitsError);
      when(
        () => authCubit.l10n.passcodeSequentialDigitsError,
      ).thenReturn(Mockl10n.passcodeSequentialDigitsError);
    }

    blocTest<AuthCubit, AuthState>(
      '.isNextButtonEnabled: is false with empty values',
      build: () {
        return authCubit;
      },
      act: (cubit) async {
        authCubit.isNextButtonEnabled.listen((event) {
          expect(event, false);
        });

        authCubit
          ..updateName('')
          ..updateEmail('');
      },
      expect: () => <AuthState>[],
    );

    blocTest<AuthCubit, AuthState>(
      '.isNextButtonEnabled: is true with user inputs',
      build: () {
        return authCubit;
      },
      act: (cubit) async {
        authCubit.isNextButtonEnabled.listen((event) {
          expect(event, true);
        });

        authCubit
          ..updateName('test')
          ..updateEmail('test');
      },
      expect: () => <AuthState>[],
    );

    blocTest<AuthCubit, AuthState>(
      'returns a [nameLengthError] when name has less than 2 characters',
      build: () {
        setUpL10n();
        return authCubit;
      },
      act: (cubit) => authCubit
        ..updateName('t')
        ..updateEmail('test@gmail.com')
        ..handleNext(
          onError: (error) => expect(error, Mockl10n.nameLengthError),
        ),
      expect: () => <AuthState>[],
    );

    blocTest<AuthCubit, AuthState>(
      'returns a [nameValidError] when name is not a valid string',
      build: () {
        setUpL10n();
        return authCubit;
      },
      act: (cubit) => authCubit
        ..updateName('t8234')
        ..updateEmail('test@gmail.com')
        ..handleNext(
          onError: (error) => expect(error, Mockl10n.nameValidError),
        ),
      expect: () => <AuthState>[],
    );

    blocTest<AuthCubit, AuthState>(
      'returns a [emailValidError] when email is not a valid string',
      build: () {
        setUpL10n();
        return authCubit;
      },
      act: (cubit) => authCubit
        ..updateName('test')
        ..updateEmail('test@gmail.')
        ..handleNext(
          onError: (error) => expect(error, Mockl10n.emailValidError),
        ),
      expect: () => <AuthState>[],
    );

    blocTest<AuthCubit, AuthState>(
      'emits  [AuthStateValidNameAndEmail] when email and name are valid',
      build: () {
        setUpL10n();
        return authCubit;
      },
      act: (cubit) => authCubit
        ..updateName('test')
        ..updateEmail('test@gmail.com')
        ..handleNext(
          onSuccess: () => expect(
            authCubit.state,
            isA<AuthStateValidNameAndEmail>(),
          ),
        ),
      expect: () => <AuthState>[AuthStateValidNameAndEmail()],
    );

    blocTest<AuthCubit, AuthState>(
      'returns a [passcodeLengthError] when passcode is not a 6 digits long',
      build: () {
        setUpL10n();
        return authCubit;
      },
      act: (cubit) => authCubit
        ..updatePasscode('032')
        ..handleConfirm(
          onError: (error) => expect(error, Mockl10n.passcodeLengthError),
        ),
      expect: () => <AuthState>[],
    );

    blocTest<AuthCubit, AuthState>(
      'returns a [passcodeDuplicateDigitsError] '
      'when digits repeat themselves more than 2 times',
      build: () {
        setUpL10n();
        return authCubit;
      },
      act: (cubit) => authCubit
        ..updatePasscode('333232')
        ..handleConfirm(
          onError: (error) =>
              expect(error, Mockl10n.passcodeDuplicateDigitsError),
        ),
      expect: () => <AuthState>[],
    );

    blocTest<AuthCubit, AuthState>(
      'returns a [passcodeSequentialDigitsError] when passcode contains '
      'a simple sequence',
      build: () {
        setUpL10n();
        return authCubit;
      },
      act: (cubit) => authCubit
        ..updatePasscode('123456')
        ..handleConfirm(
          onError: (error) =>
              expect(error, Mockl10n.passcodeSequentialDigitsError),
        ),
      expect: () => <AuthState>[],
    );

    blocTest<AuthCubit, AuthState>(
      'emits  [AuthStateValidPasscode] when a valid passcode is entered',
      build: () {
        setUpL10n();
        return authCubit;
      },
      act: (cubit) => authCubit
        ..updatePasscode('394215')
        ..handleConfirm(
          onSuccess: () => expect(
            authCubit.state,
            isA<AuthStateValidPasscode>(),
          ),
        ),
      expect: () => <AuthState>[AuthStateValidPasscode()],
    );

    blocTest<AuthCubit, AuthState>(
      'verify .reset() is called',
      build: () {
        TestWidgetsFlutterBinding.ensureInitialized();
        return authCubit;
      },
      seed: AuthStateValidPasscode.new,
      act: (cubit) => authCubit.reset(),
      expect: () => <AuthState>[AuthStateInitial()],
    );
  });
}
