import 'package:domain/model/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotted/application/colorful.dart';
import 'package:spotted/application/dimen.dart';
import 'package:foundation/dates.dart';

class CardTile extends StatelessWidget {
  const CardTile({
    required this.post,
  });

  final Post post;

  static const double _borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius),
        side: const BorderSide(color: Colorful.silver),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(Insets.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  post.createdAt.toTimaAgo,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Colorful.silverChalice,
                      ),
                ),
              ],
            ),
            const SizedBox(height: Insets.xSmall),
            Text(
              post.body,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }
}
