import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_challenge/auth/counter.dart';
import 'package:flutter_challenge/core/services/router.dart';
import 'package:flutter_challenge/core/utils/colors.dart';
import 'package:flutter_challenge/core/utils/extensions.dart';
import 'package:flutter_challenge/l10n/l10n.dart';
import 'package:flutter_challenge/widgets/fc_button.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class CreatePasscodePage extends StatelessWidget {
  CreatePasscodePage({super.key}) {
    focusNode.requestFocus();
  }

  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 16,
        color: kNeutral90,
      ),
      decoration: BoxDecoration(
        color: kNeutral200,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: kNeutral90,
          width: 2,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: CupertinoNavigationBarBackButton(
            color: const Color(0XFF323232),
            onPressed: () => context.pop(),
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              l10n.createPasscodeAppBarTitle,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: kNeutral90,
              ),
            ),
            const Gap(4),
            Text(
              l10n.createPasscodeSubTitle,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: kNeutral500,
              ),
            ),
            const Gap(42),
            Pinput(
              focusNode: focusNode,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              length: 6,
              defaultPinTheme: defaultPinTheme,
              showCursor: false,
              obscureText: true,
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onChanged: context.read<AuthCubit>().updatePasscode,
              onCompleted: (_) => focusNode.requestFocus(),
              followingPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: Colors.transparent),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: kNeutral20,
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
            Gap(context.screenHeight(.2)),
            FCButton(
              text: l10n.confirm,
              onTap: () => context.read<AuthCubit>().handleConfirm(
                    onError: (error) => context.showError(error),
                    onSuccess: () => context.pushNamed(
                      Routes.mainPage,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
