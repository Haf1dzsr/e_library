import 'package:e_library/common/constants/images.dart';
import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:flutter/material.dart';

class NewestBookCardWidget extends StatelessWidget {
  const NewestBookCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.325,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                Images.onBoardingEnjoy,
                height: MediaQuery.sizeOf(context).height / 4.75,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'The Great Gatsby',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              style: appTheme.textTheme.titleMedium!.copyWith(
                color: AppColor.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'F. Scott Fitzgerald',
              style: appTheme.textTheme.bodyMedium!.copyWith(
                color: AppColor.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
