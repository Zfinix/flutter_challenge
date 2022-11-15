part of 'auth_cubit.dart';

abstract class AuthState with EquatableMixin {
  @override
  bool? get stringify => true;
}

class AuthStateInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthStateValidNameAndEmail extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthStateValidPasscode extends AuthState {
  @override
  List<Object?> get props => [];
}

enum CreateAccountErrors {
  nameLengthError,
  nameValidError,
  emailValidError,
  passcodeLengthError,
  passcodeDuplicateDigitsError,
  passcodeSequentialDigitsError,
}
