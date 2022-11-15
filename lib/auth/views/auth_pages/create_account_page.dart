import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/auth/counter.dart';
import 'package:flutter_challenge/core/services/router.dart';
import 'package:flutter_challenge/core/utils/colors.dart';
import 'package:flutter_challenge/core/utils/extensions.dart';
import 'package:flutter_challenge/l10n/l10n.dart';
import 'package:flutter_challenge/widgets/fc_button.dart';
import 'package:flutter_challenge/widgets/fc_text_field.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final nameStream = context.select(
      (AuthCubit it) => it.nameStream,
    );

    final emailStream = context.select(
      (AuthCubit it) => it.emailStream,
    );

    final isNextButtonEnabled = context.select(
      (AuthCubit it) => it.isNextButtonEnabled,
    );

    final formKey = context.select(
      (AuthCubit it) => it.formKey,
    );

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Gap(100),
              Text(
                l10n.createAccountAppBarTitle,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: kNeutral90,
                ),
              ),
              const Gap(30),
              FCTextField(
                key: const Key('FCTextField-Name'),
                labelText: l10n.name,
                stream: nameStream,
                onChanged: context.read<AuthCubit>().updateName,
              ),
              const Gap(20),
              FCTextField(
                key: const Key('FCTextField-Email'),
                labelText: l10n.email,
                stream: emailStream,
                onChanged: context.read<AuthCubit>().updateEmail,
              ),
              Gap(context.screenHeight(.1)),
              FCButton(
                text: l10n.next,
                defaultEnabledValue: false,
                enabledStream: isNextButtonEnabled,
                onTap: () => context.read<AuthCubit>().handleNext(
                      onError: (error) => context.showError(error),
                      onSuccess: () => context.pushNamed(
                        Routes.createPasscodePage,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
