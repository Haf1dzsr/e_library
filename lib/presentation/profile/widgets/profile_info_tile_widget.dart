import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ProfileInfoTileWidget extends StatelessWidget {
  const ProfileInfoTileWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: appTheme.textTheme.titleLarge!
                    .copyWith(color: AppColor.textSecondary),
              ),
              Text(
                value,
                style: appTheme.textTheme.titleLarge!
                    .copyWith(color: AppColor.textSecondary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Divider(
          color: AppColor.textSecondary,
        ),
      ],
    );
  }
}
