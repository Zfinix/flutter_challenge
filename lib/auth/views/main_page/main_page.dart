import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/auth/auth.dart';
import 'package:flutter_challenge/core/utils/colors.dart';
import 'package:flutter_challenge/core/utils/extensions.dart';
import 'package:flutter_challenge/l10n/l10n.dart';
import 'package:flutter_challenge/widgets/fc_button.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final nameStream = context.select(
      (AuthCubit it) => it.nameStream,
    );

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            Gap(context.screenHeight(.08)),
            Image.asset(
              'assets/images/png/avatar.png',
              height: 211,
            ),
            const Gap(20),
            Center(
              child: StreamBuilder<String>(
                stream: nameStream,
                builder: (context, snapshot) {
                  return Text(
                    snapshot.data ?? '',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: kNeutral90,
                    ),
                  );
                },
              ),
            ),
            Gap(context.screenHeight(.4)),
            Row(
              children: [
                Flexible(
                  child: FCButton(
                    key: const Key('FCButton-clearAccount'),
                    width: double.infinity,
                    text: l10n.clearAccount,
                    color: kNeutral700,
                    onTap: () => logout(context),
                  ),
                ),
                const Gap(15),
                Flexible(
                  child: FCButton(
                    key: const Key('FCButton-logOut'),
                    text: l10n.logOut,
                    width: double.infinity,
                    onTap: () => logout(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void logout(BuildContext context) {
    context.read<AuthCubit>().reset();
    Navigator.of(context).popUntil((route) => route.isFirst);
    context.replace('/');
  }
}
