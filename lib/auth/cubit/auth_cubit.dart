import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/core/utils/validator.dart';
import 'package:flutter_challenge/l10n/l10n.dart';
import 'package:rxdart/rxdart.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.l10n) : super(AuthStateInitial());

  final validator = Validator();
  final formKey = GlobalKey<FormState>();

  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passcodeController = BehaviorSubject<String>();

  Stream<String> get nameStream => _nameController.stream;
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passcodeStream => _passcodeController.stream;

  final AppLocalizations l10n;

  /// Handle update events for textfields
  void updateName(String text) {
    _nameController.sink.add(text);
  }

  void updateEmail(String text) {
    _emailController.sink.add(text);
  }

  void updatePasscode(String text) {
    _passcodeController.sink.add(text);
  }

  /// Controls if the next button on `CreateAccountPage` is enabled or not
  Stream<bool> get isNextButtonEnabled => Rx.combineLatest2(
        nameStream,
        emailStream,
        (a, b) =>
            _nameController.value.isNotEmpty &&
            _emailController.value.isNotEmpty,
      );

  /// Handle `onError` and `onSuccess` events
  void handleNext({
    ValueChanged<String>? onError,
    VoidCallback? onSuccess,
  }) {
    final email = _emailController.value;
    final name = _nameController.value;

    if (validator.hasMin2chars(name) == false) {
      onError?.call(l10n.nameLengthError);
      return;
    }

    if (validator.validName(name) == false) {
      onError?.call(l10n.nameValidError);
      return;
    }

    if (validator.isEmail(email) == false) {
      onError?.call(l10n.emailValidError);
      return;
    }

    emit(AuthStateValidNameAndEmail());
    onSuccess?.call();
  }

  /// Validates user's passcode input
  void handleConfirm({
    ValueChanged<String>? onError,
    VoidCallback? onSuccess,
  }) {
    final passcode = _passcodeController.value;

    if (passcode.length != 6) {
      onError?.call(l10n.passcodeLengthError);
      return;
    }
    if (validator.containsDuplicates(passcode)) {
      onError?.call(l10n.passcodeDuplicateDigitsError);
      return;
    }

    if (validator.containsASequence(passcode)) {
      onError?.call(l10n.passcodeSequentialDigitsError);
      return;
    }

    emit(AuthStateValidPasscode());
    onSuccess?.call();
  }

  /// Reset form state
  void reset() {
    formKey.currentState?.reset();
    emit(AuthStateInitial());
  }
}
