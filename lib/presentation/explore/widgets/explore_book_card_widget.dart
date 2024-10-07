import 'package:e_library/common/constants/images.dart';
import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ExploreBookCardWidget extends StatelessWidget {
  const ExploreBookCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      Images.onBoardingWelcome,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        Images.onBoardingWelcome,
                      ),
                      height: MediaQuery.sizeOf(context).height * 0.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Atomic Habits',
                        style: appTheme.textTheme.titleMedium!.copyWith(
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'By: James Clear',
                        style: appTheme.textTheme.bodyMedium!.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.603,
                        child: Text(
                          'lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                          style: appTheme.textTheme.bodySmall!.copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Go to detail page
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: 22,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.primary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'See Details',
                            style: appTheme.textTheme.labelSmall!
                                .copyWith(color: AppColor.primary),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Divider(
            color: AppColor.grey,
          )
        ],
      ),
    );
  }
}
