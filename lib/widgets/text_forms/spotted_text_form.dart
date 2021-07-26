import 'package:flutter/material.dart';
import 'package:spotted/application/theme.dart';

class SpottedTextForm extends StatelessWidget {
  const SpottedTextForm({
    this.hintText,
    this.prefix,
    this.textCapitalization = TextCapitalization.sentences,
    this.keyboardType,
    this.textInputAction,
    this.autofocus = false,
    this.focusNode,
    this.onChanged,
    this.controller,
  });

  final String? hintText;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      autofocus: autofocus,
      textCapitalization: textCapitalization,
      style: Theme.of(context).textTheme.button?.copyWith(color: ProjectColors.gray2),
      decoration: InputDecoration(
        prefix: prefix,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: ProjectColors.gray8,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
