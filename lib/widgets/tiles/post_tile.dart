import 'package:domain/model/post.dart';
import 'package:flutter/material.dart';
import 'package:foundation/dates.dart';
import 'package:spotted/application/dimen.dart';

class PostTile extends StatelessWidget {
  const PostTile({
    required this.creationDate,
    required this.body,
    this.commentCount,
    this.onTap,
  });

  final DateTime creationDate;
  final String body;
  final int? commentCount;
  final VoidCallback? onTap;

  static const double _borderRadius = 8;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_borderRadius),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(Insets.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      creationDate.toTimaAgo,
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
                ),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: Insets.medium),
                Row(
                  children: [
                    if (commentCount != null) ...[
                      _CommentCountContainer(
                        commentCount: commentCount!,
                      )
                    ]
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CommentCountContainer extends StatelessWidget {
  const _CommentCountContainer({
    required this.commentCount,
  });

  final int commentCount;

  static const double _iconSize = 20;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.chat_bubble_outline_rounded,
          size: _iconSize,
        ),
        const SizedBox(width: Insets.medium),
        Text(
          commentCount.toString(),
          style: Theme.of(context).textTheme.subtitle1,
        )
      ],
    );
  }
}
