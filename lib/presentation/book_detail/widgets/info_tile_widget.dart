import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:flutter/material.dart';

class InfoTileWidget extends StatelessWidget {
  const InfoTileWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: appTheme.textTheme.labelSmall!.copyWith(
              color: AppColor.textSecondary,
            ),
          ),
          Text(
            value,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: appTheme.textTheme.bodySmall!.copyWith(
              color: AppColor.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
