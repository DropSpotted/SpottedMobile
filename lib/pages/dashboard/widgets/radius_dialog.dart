import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:domain/model/enum/radius_enum.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spotted/application/dimen.dart';
import 'package:spotted/pages/dashboard/widgets/radius_tile.dart';
import 'package:spotted/widgets/buttons/spotted_button.dart';
import 'package:spotted/widgets/buttons/spotted_outlined_button.dart';
import 'package:spotted/application/application_export.dart';

abstract class SpottedRadiusDialog<T> {
  static Future show<T>(
    BuildContext context, {
    void Function(RadiusEnum)? onSaveChanges,
    required RadiusEnum radius,
  }) {
    return showDialog(
      context: context,
      builder: (_) => _RadiusDialog(
        onSaveChanges: onSaveChanges,
        radius: radius,
      ),
    );
  }
}

class _RadiusDialog extends HookWidget {
  const _RadiusDialog({
    Key? key,
    this.onSaveChanges,
    required this.radius,
  }) : super(key: key);

  final void Function(RadiusEnum)? onSaveChanges;
  final RadiusEnum radius;

  String _getRadiusEnumTitle(RadiusEnum radius) {
    switch (radius) {
      case RadiusEnum.short:
        return '${RadiusEnum.short.toDistance()} m radius 🏠';
      case RadiusEnum.medium:
        return '${RadiusEnum.medium.toDistance()} m radius 🏙️';

      case RadiusEnum.long:
        return '${RadiusEnum.long.toDistance()} m radius 🌍';
    }
  }

  @override
  Widget build(BuildContext context) {
    final radiusState = useState(radius);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Material(
          borderRadius: BorderRadius.circular(26),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Insets.xxLarge, horizontal: Insets.xxLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Show posts from',
                  style: context.textThemes.hheadline,
                  // style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: Insets.xxLarge),
                ...RadiusEnum.values
                    .map(
                      (radius) => RadiusTile<RadiusEnum>(
                        value: radiusState.value,
                        groupValue: radius,
                        title: _getRadiusEnumTitle(radius),
                        onTap: (value) => radiusState.value = value,
                      ),
                    )
                    .toList(),
                const SizedBox(height: Insets.xxLarge),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SpottedButton(
                      text: 'Save changes',
                      spottedButtonType: SpottedButtonType.medium,
                      onPressed: () async {
                        if (onSaveChanges != null) {
                          onSaveChanges!(radiusState.value);
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                    SpottedOutlinedButton(
                      text: 'Cancel',
                      onTap: () => Navigator.of(context).pop(),
                      type: SpottedOutlinedButtonType.medium,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
