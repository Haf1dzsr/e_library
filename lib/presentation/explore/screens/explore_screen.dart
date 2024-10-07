import 'package:e_library/common/constants/images.dart';
import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/presentation/explore/widgets/category_widget.dart';
import 'package:e_library/presentation/explore/widgets/explore_book_card_widget.dart';
import 'package:e_library/presentation/explore/widgets/newest_book_card_widget.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});

  ValueNotifier<String> selectedCategory = ValueNotifier('All');
  final List<String> categories = [
    'All',
    'Fiction',
    'Non-Fiction',
    'Horror',
    'Romance',
    'Mystery',
    'Fantasy',
    'Biography'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.sizeOf(context).height / 4,
                padding: const EdgeInsets.only(left: 16),
                decoration: const BoxDecoration(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(96),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        Images.avatar,
                        color: AppColor.white,
                        fit: BoxFit.cover,
                        height: MediaQuery.sizeOf(context).height / 14,
                        width: MediaQuery.sizeOf(context).width / 7,
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, Hafidz Surya Ramadhan',
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            style: appTheme.textTheme.headlineMedium!.copyWith(
                              color: AppColor.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'hafidzsr@icloud.com',
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            style: appTheme.textTheme.bodyMedium!.copyWith(
                              color: AppColor.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColor.primary.withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Go to profile',
                                style: appTheme.textTheme.labelMedium!.copyWith(
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Newest Books',
                      style: appTheme.textTheme.headlineMedium!.copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height / 3.725,
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 16),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return const NewestBookCardWidget();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore Books',
                      style: appTheme.textTheme.headlineMedium!.copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ValueListenableBuilder<String>(
                      valueListenable: selectedCategory,
                      builder: (context, value, _) {
                        return SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.035,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              final isSelected = value == category;
                              return CategoryWidget(
                                selectedCategory: selectedCategory,
                                category: category,
                                isSelected: isSelected,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return const ExploreBookCardWidget();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
