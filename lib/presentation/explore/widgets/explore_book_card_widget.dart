import 'dart:io';

import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/data/models/book_model.dart';
import 'package:flutter/material.dart';

class ExploreBookCardWidget extends StatelessWidget {
  const ExploreBookCardWidget({
    super.key,
    required this.book,
  });

  final BookModel book;

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
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.file(
                  File(book.bookCover),
                  width: MediaQuery.sizeOf(context).width * 0.275,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  fit: BoxFit.fitHeight,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      size: MediaQuery.sizeOf(context).height / 7.75,
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: appTheme.textTheme.titleMedium!.copyWith(
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'By: ${book.author}',
                        style: appTheme.textTheme.bodyMedium!.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.603,
                        height: MediaQuery.sizeOf(context).height * 0.12,
                        child: Text(
                          book.synopsis,
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
