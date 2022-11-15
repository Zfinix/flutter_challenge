import 'package:flutter/material.dart';
import 'package:flutter_challenge/core/utils/colors.dart';
import 'package:flutter_challenge/core/utils/constants.dart';
import 'package:flutter_challenge/core/utils/extensions.dart';
import 'package:flutter_challenge/widgets/touchable_opacity.dart';

class FCButton extends StatelessWidget {
  const FCButton({
    super.key,
    this.onTap,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.color,
    this.textColor,
    this.borderColor,
    this.fontSize,
    this.defaultEnabledValue,
    this.enabledStream = const Stream.empty(),
    this.child,
    this.text = '',
  });

  final VoidCallback? onTap;
  final double? width, height, fontSize, borderRadius;
  final String text;
  final bool? defaultEnabledValue;
  final EdgeInsetsGeometry? padding;
  final Stream<bool> enabledStream;
  final Color? color, textColor, borderColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: enabledStream,
      builder: (context, snapshot) {
        final enabled = snapshot.data ?? (defaultEnabledValue ?? true);
        return AnimatedOpacity(
          opacity: enabled ? 1.0 : 0.2,
          duration: kAnimationDuration,
          child: SizedBox(
            width: width ?? context.screenWidth(.86),
            height: height,
            child: TouchableOpacity(
              onTap: enabled ? onTap : null,
              decoration: BoxDecoration(
                color: color ?? kBlueMain,
                borderRadius: BorderRadius.circular(borderRadius ?? 16),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 16),
                    blurRadius: 32,
                    color: Colors.black.withOpacity(0.14),
                  ),
                  BoxShadow(
                    offset: const Offset(0, 6),
                    blurRadius: 14,
                    color: Colors.black.withOpacity(0.08),
                  ),
                ],
              ),
              child: Padding(
                padding: padding ??
                    const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                child: child ??
                    Center(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: fontSize ?? 18,
                          fontWeight: FontWeight.w600,
                          color: textColor ?? Colors.white,
                        ),
                      ),
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}
