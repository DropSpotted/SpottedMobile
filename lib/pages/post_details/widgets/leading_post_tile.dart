import 'package:domain/model/detailed_post.dart';
import 'package:flutter/material.dart';
import 'package:spotted/application/colorful.dart';
import 'package:spotted/application/dimen.dart';
import 'package:foundation/dates.dart';

class LeadingPostTile extends StatelessWidget {
  const LeadingPostTile({
    required DetailedPost detailedPost,
  }) : _detailedPost = detailedPost;

  final DetailedPost _detailedPost;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colorful.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _detailedPost.createdAt.toTimaAgo,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Colorful.silverChalice,
                    ),
              ),
            ],
          ),
          const SizedBox(height: Insets.xSmall),
          Text(
            _detailedPost.body,
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
