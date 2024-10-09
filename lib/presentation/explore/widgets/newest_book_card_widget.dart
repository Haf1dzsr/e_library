import 'dart:io';

import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/data/models/book_model.dart';
import 'package:e_library/presentation/book_detail/screens/book_detail_screen.dart';
import 'package:flutter/material.dart';

class NewestBookCardWidget extends StatelessWidget {
  const NewestBookCardWidget({
    super.key,
    required this.book,
  });

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailScreen(id: book.id!),
          ),
        );
      },
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.325,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.file(
                File(book.bookCover),
                height: MediaQuery.sizeOf(context).height / 4.75,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported,
                    size: MediaQuery.sizeOf(context).height / 7.75,
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book.title,
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
              book.author,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
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
