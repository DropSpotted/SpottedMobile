import 'package:flutter/widgets.dart';
import 'package:spotted/application/application_export.dart';
import 'package:spotted/widgets/containers/rate_container.dart';
import 'package:foundation/dates.dart';
import 'package:domain/model/user_shorten.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({
    Key? key,
    required this.creationDate,
    required this.body,
    required this.user,
  }) : super(key: key);

  final DateTime creationDate;
  final String body;
  final UserShorten user;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colorful.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(Insets.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Posted by ${user.username} • ${creationDate.toTimaAgo}',
              style: context.textThemes.caption?.copyWith(color: Colorful.gray8),
            ),
            const SizedBox(height: Insets.medium),
            Text(body, style: context.textThemes.buttonMedium),
            const SizedBox(height: Insets.medium),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                RateContainer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
