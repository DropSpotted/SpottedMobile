import 'package:flutter/widgets.dart';
import 'package:spotted/application/application_export.dart';

class ProfileSumUpContainer extends StatelessWidget {
  const ProfileSumUpContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.xxLarge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _SingleSumUpTile(
            title: '100',
            subTitle: 'Points',
          ),
          _SingleSumUpTile(
            title: '12',
            subTitle: 'Posts',
          ),
          _SingleSumUpTile(
            title: '5',
            subTitle: 'Comments',
          ),
        ],
      ),
    );
  }
}

class _SingleSumUpTile extends StatelessWidget {
  const _SingleSumUpTile({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Text(
          subTitle,
          style: context.textThemes.caption?.copyWith(
            color: Colorful.gray8,
          ),
        ),
      ],
    );
  }
}
