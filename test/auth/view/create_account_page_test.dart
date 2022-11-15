// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/auth/counter.dart';
import 'package:flutter_challenge/widgets/fc_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  group('CreateAccountPage', () {
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

    testWidgets('renders text field values', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: authCubit,
          child: const CreateAccountPage(),
        ),
      );

      await tester.enterText(
        find.byKey(const Key('FCTextField-Email')),
        'chizi@test.com',
      );

      await tester.enterText(
        find.byKey(const Key('FCTextField-Name')),
        'Chizi',
      );

      await tester.pump();

      expect(find.text('chizi@test.com'), findsOneWidget);
      expect(find.text('Chizi'), findsOneWidget);
    });

    testWidgets('calls .handleNext() when Next button is tapped',
        (tester) async {
      when(
        () => authCubit.handleNext(
          onError: (_) => any(named: 'onError'),
          onSuccess: () => any(named: 'onSuccess'),
        ),
      ).thenAnswer((_) => {});

      await tester.pumpApp(
        BlocProvider.value(
          value: authCubit,
          child: const CreateAccountPage(),
        ),
      );
      await tester.enterText(
        find.byKey(const Key('FCTextField-Email')),
        'chizi@test.com',
      );

      await tester.enterText(
        find.byKey(const Key('FCTextField-Name')),
        'Chizi',
      );

      await tester.pump();
      await tester.tap(find.byType(FCButton));

      verify(
        () => authCubit.handleNext(
          onError: any(named: 'onError'),
          onSuccess: any(named: 'onSuccess'),
        ),
      ).called(1);
    });
  });
}
