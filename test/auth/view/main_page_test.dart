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
import 'package:flutter_challenge/auth/views/main_page/main_page.dart';
import 'package:flutter_challenge/core/services/router.dart';
import 'package:flutter_challenge/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
  group('MainPage success', () {
    late AuthCubit authCubit;

    setUpAll(() {
      authCubit = _MockAuthCubit();

      when(() => authCubit.state).thenReturn(AuthStateInitial());

      when(() => authCubit.nameStream).thenAnswer(
        (_) => Stream.value('Chizi'),
      );
    });

    testWidgets('renders user name', (tester) async {
      await tester.pumpApp(
        BlocProvider.value(
          value: authCubit,
          child: const MainPage(),
        ),
      );
      await tester.pump();

      expect(find.text('Chizi'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets(
        'calls .reset() when Logout and Clear Account buttons are tapped',
        (tester) async {
      when(() => authCubit.formKey).thenAnswer((_) => GlobalKey<FormState>());

      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            name: Routes.mainPage,
            path: '/',
            builder: (_, __) => const MainPage(),
          )
        ],
      );

      when(
        () => authCubit.reset(),
      ).thenAnswer((_) => {});

      await tester.pumpApp(
        BlocProvider.value(
          value: authCubit,
          child: MaterialApp.router(
            routerConfig: router,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
          ),
        ),
      );

      await tester.pump();
      await tester.tap(find.byKey(const Key('FCButton-clearAccount')));
      verify(() => authCubit.reset()).called(1);

      await tester.tap(find.byKey(const Key('FCButton-logOut')));
      verify(() => authCubit.reset()).called(1);
    });
  });
}
