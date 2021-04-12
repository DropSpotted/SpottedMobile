import 'package:domain/model/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotted/application/colorful.dart';
import 'package:spotted/application/dimen.dart';
import 'package:foundation/dates.dart';

class CardTile extends StatelessWidget {
  const CardTile({
    required this.post,
    this.onPressed
  });

  final Post post;
  final Function()? onPressed;

  static const double _borderRadius = 6.0;
  static const double _cardElevation = 0.3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
          // side: const BorderSide(color: Colorful.silver),
        ),
        elevation: _cardElevation,
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
      ),
    );
  }
}
