import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/core/utils/colors.dart';
import 'package:gap/gap.dart';

class FCTextField extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  FCTextField({
    this.key,
    required this.labelText,
    required this.stream,
    this.onChanged,
  });

  final String labelText;

  @override
  // ignore: overridden_fields
  final Key? key;

  final Stream<String> stream;
  final ValueChanged<String>? onChanged;

  final kEmptyBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      style: BorderStyle.none,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 20,
            color: kNeutral90,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(4),
        StreamBuilder<String>(
          stream: stream,
          builder: (context, snapshot) {
            return TextFormField(
              key: key,
              onChanged: onChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: kNeutral200,
                border: kEmptyBorder,
                focusedBorder: kEmptyBorder,
                enabledBorder: kEmptyBorder,
                errorBorder: kEmptyBorder,
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Key?>('key', key));
  }
}
