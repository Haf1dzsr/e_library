import 'dart:io';

import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/data/models/book_model.dart';
import 'package:flutter/material.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: AppColor.primary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Book Detail',
          style: appTheme.textTheme.labelLarge!.copyWith(
            color: AppColor.primary,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.sizeOf(context).height * 0.09),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.file(
                    File(book.bookCover),
                    height: MediaQuery.sizeOf(context).height / 3,
                    width: MediaQuery.sizeOf(context).width * 0.65,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_not_supported,
                        size: MediaQuery.sizeOf(context).height / 7.75,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: Text(
                  book.title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  style: appTheme.textTheme.headlineMedium!.copyWith(
                    color: AppColor.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'By: ${book.author}',
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                style: appTheme.textTheme.bodyMedium!.copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.grey.withOpacity(0.2),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Published Year',
                            textAlign: TextAlign.center,
                            style: appTheme.textTheme.labelSmall!.copyWith(
                              color: AppColor.textSecondary,
                            ),
                          ),
                          Text(
                            book.publishedYear.toString(),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: appTheme.textTheme.bodySmall!.copyWith(
                              color: AppColor.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.03,
                      child: const VerticalDivider(
                        color: AppColor.grey,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Genre',
                            textAlign: TextAlign.center,
                            style: appTheme.textTheme.labelSmall!.copyWith(
                              color: AppColor.textSecondary,
                            ),
                          ),
                          Text(
                            book.genre,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: appTheme.textTheme.bodySmall!.copyWith(
                              color: AppColor.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.03,
                      child: const VerticalDivider(
                        color: AppColor.grey,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Page Total',
                            textAlign: TextAlign.center,
                            style: appTheme.textTheme.labelSmall!.copyWith(
                              color: AppColor.textSecondary,
                            ),
                          ),
                          Text(
                            book.pageTotal.toString(),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: appTheme.textTheme.bodySmall!.copyWith(
                              color: AppColor.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                book.synopsis,
                textAlign: TextAlign.justify,
                style: appTheme.textTheme.bodyMedium!.copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.13,
            height: MediaQuery.sizeOf(context).height * 0.06,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: AppColor.white,
              child: const Icon(
                Icons.bookmark_border_outlined,
                size: 24,
                color: AppColor.primary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.06,
            width: MediaQuery.sizeOf(context).width * 0.775,
            child: FloatingActionButton.extended(
              onPressed: () {},
              backgroundColor: AppColor.primary,
              label: Text(
                'Start Reading',
                style: appTheme.textTheme.labelMedium!.copyWith(
                  color: AppColor.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
