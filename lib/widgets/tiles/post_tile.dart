import 'package:flutter/material.dart';
import 'package:foundation/dates.dart';
import 'package:spotted/application/application_export.dart';
import 'package:domain/model/user_shorten.dart';
import 'package:spotted/widgets/containers/rate_container.dart';

class PostTile extends StatelessWidget {
  const PostTile({
    required this.creationDate,
    required this.body,
    required this.place,
    this.isAnonymous = false,
    this.user,
    this.commentCount,
    this.onTap,
  });

  final DateTime creationDate;
  final String place;
  final String body;
  final int? commentCount;
  final VoidCallback? onTap;
  final UserShorten? user;
  final bool isAnonymous;

  static const double _colorOpacity = 0.12;
  static const double _buttonRadius = 12;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(_buttonRadius),
      color: Colorful.white,
      child: InkResponse(
        containedInkWell: false,
        onTap: onTap,
        highlightColor: Colorful.gray6.withOpacity(_colorOpacity),
        highlightShape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(_buttonRadius),
        splashColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isAnonymous) ...[
                Text('Posted by anonymous', style: context.textThemes.buttonMedium),
              ],
              if (!isAnonymous && user?.username != null) ...[
                Text('Posted by ${user!.username}', style: context.textThemes.buttonMedium),
              ],
              const SizedBox(height: Insets.xSmall),
              Text(
                '$place • ${creationDate.toTimaAgo}',
                style: context.textThemes.caption?.copyWith(color: Colorful.gray8),
              ),
              const SizedBox(height: Insets.large),
              Text(body, style: context.textThemes.buttonMedium),
              const SizedBox(height: Insets.large),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CommentCountContainer(
                    commentCount: commentCount ?? 0,
                  ),
                  const RateContainer(),
                ],
              ),
            ],
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

  static const double _iconSize = 14;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.chat_bubble_outline_rounded,
          size: _iconSize,
          color: Colorful.gray6,
        ),
        const SizedBox(width: Insets.small),
        Text(
          commentCount.toString(),
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: Colorful.gray6,
              ),
        )
      ],
    );
  }
}

// class _RateContainer extends StatelessWidget {
//   const _RateContainer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colorful.gray12,
//       borderRadius: BorderRadius.circular(8),
//       child: Row(
//         children: [
//           _VoteButton(
//             icon: Icons.arrow_drop_up,
//             onTap: () {},
//           ),
//           const Text('1'),
//           _VoteButton(
//             icon: Icons.arrow_drop_down,
//             onTap: () {},
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _VoteButton extends StatelessWidget {
//   const _VoteButton({
//     Key? key,
//     required this.icon,
//     this.onTap,
//   }) : super(key: key);

//   final IconData icon;
//   final VoidCallback? onTap;

//   static const double _colorOpacity = 0.12;
//   static const double _buttonRadius = 12;

//   @override
//   Widget build(BuildContext context) {
//     return InkResponse(
//       highlightColor: Colorful.gray6.withOpacity(_colorOpacity),
//       highlightShape: BoxShape.rectangle,
//       borderRadius: BorderRadius.circular(_buttonRadius),
//       splashColor: Colors.transparent,
//       containedInkWell: false,
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.all(5),
//         child: Icon(icon),
//       ),
//     );
//   }
// }
