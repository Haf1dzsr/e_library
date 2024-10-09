import 'package:e_library/common/themes/app_color.dart';
import 'package:flutter/material.dart';

class VerticalDividerWidget extends StatelessWidget {
  const VerticalDividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.03,
      child: VerticalDivider(
        color: AppColor.grey.withOpacity(0.7),
        thickness: 1,
      ),
    );
  }
}
