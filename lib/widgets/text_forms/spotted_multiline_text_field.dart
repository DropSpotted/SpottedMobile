import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spotted/application/application_export.dart';

class SpottedMultilineTextField extends HookWidget {
  const SpottedMultilineTextField({
    this.maxLength,
    this.autofocus = true,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
  });

  final int? maxLength;
  final bool autofocus;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;


  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final controller = useTextEditingController();
    final charsCount = useState(controller.text.length);
    final hasFocus = useState(focusNode.hasFocus);
    
    controller.addListener(() {
      charsCount.value = controller.text.length;
    });

    focusNode.addListener(() {
      hasFocus.value = focusNode.hasFocus;
    });

    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: focusNode.hasFocus ? context.themeData.accentColor : Colorful.gray8,
          )),
      child: Padding(
        padding: const EdgeInsets.all(Insets.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Write whats going on...',
                  style: context.textThemes.bodySmall.copyWith(color: Colorful.gray2),
                ),
                if (maxLength != null)
                  Text(
                    '${charsCount.value}/$maxLength',
                    style: context.textThemes.bodySmall.copyWith(color: Colorful.gray2),
                  ),
              ],
            ),
            Expanded(
              child: TextField(
                onChanged: onChanged,
                controller: controller,
                focusNode: focusNode,
                autofocus: autofocus,
                maxLength: maxLength,
                textInputAction: textInputAction,
                textCapitalization: textCapitalization,
                maxLines: 100,
                style: context.textThemes.buttonMedium.copyWith(color: Colorful.gray2),
                decoration: const InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
