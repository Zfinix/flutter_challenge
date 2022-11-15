// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/auth/auth.dart';
import 'package:flutter_challenge/auth/views/auth_pages/create_passcode_page.dart';
import 'package:flutter_challenge/widgets/fc_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  group('CreatePasscodePage success', () {
    late AuthCubit authCubit;

    setUpAll(() {
      authCubit = _MockAuthCubit();

      when(() => authCubit.state).thenReturn(AuthStateInitial());

      when(() => authCubit.nameStream).thenAnswer(
        (_) => Stream.value('Chizi'),
      );

      when(() => authCubit.emailStream).thenAnswer(
        (_) => Stream.value('chizi@test.com'),
      );

      when(() => authCubit.isNextButtonEnabled)
          .thenAnswer((_) => Stream.value(true));

      when(() => authCubit.formKey).thenAnswer((_) => GlobalKey<FormState>());
    });

    testWidgets('renders pincode field values', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: authCubit,
          child: CreatePasscodePage(),
        ),
      );

      await tester.enterText(
        find.byType(EditableText),
        '298473',
      );

      await tester.pump();

      expect(find.text('298473'), findsOneWidget);
    });

    testWidgets('calls .handleConfirm() when Confirm button is tapped',
        (tester) async {
      when(
        () => authCubit.handleConfirm(
          onError: (_) => any(named: 'onError'),
          onSuccess: () => any(named: 'onSuccess'),
        ),
      ).thenAnswer((_) => {});

      await tester.pumpApp(
        BlocProvider.value(
          value: authCubit,
          child: CreatePasscodePage(),
        ),
      );

      await tester.enterText(
        find.byType(EditableText),
        '298473',
      );

      await tester.pump();
      await tester.tap(find.byType(FCButton));

      verify(
        () => authCubit.handleConfirm(
          onError: any(named: 'onError'),
          onSuccess: any(named: 'onSuccess'),
        ),
      ).called(1);
    });
  });
}
