import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.selectedCategory,
    required this.category,
    required this.isSelected,
  });

  final ValueNotifier<String> selectedCategory;
  final String category;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectedCategory.value = category;
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.sizeOf(context).width * 0.195,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColor.black : AppColor.grey,
          ),
          color: isSelected ? AppColor.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          category,
          textAlign: TextAlign.center,
          style: appTheme.textTheme.labelMedium!.copyWith(
            color: isSelected
                ? AppColor.white
                : AppColor.textSecondary, // Change text color if selected
          ),
        ),
      ),
    );
  }
}
