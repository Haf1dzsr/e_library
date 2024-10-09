import 'dart:io';

import 'package:e_library/common/constants/images.dart';
import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/presentation/explore/cubits/book_cubit/book_cubit.dart';
import 'package:e_library/presentation/explore/cubits/query_book_cubit/query_book_cubit.dart';
import 'package:e_library/presentation/explore/screens/upload_book_screen.dart';
import 'package:e_library/presentation/explore/widgets/category_widget.dart';
import 'package:e_library/presentation/explore/widgets/explore_book_card_widget.dart';
import 'package:e_library/presentation/explore/widgets/newest_book_card_widget.dart';
import 'package:e_library/presentation/profile/cubits/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ValueNotifier<String> selectedGenre = ValueNotifier('All');

  final List<String> genres = [
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
  void initState() {
    super.initState();
    context.read<BookCubit>().getNewestBooks();
    context.read<QueryBookCubit>().getExploreBooks(selectedGenre.value);
    context.read<ProfileCubit>().getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColor.primary,
                          ),
                        ),
                      );
                    },
                    loaded: (user) {
                      return Container(
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
                              child: user.photo != ''
                                  ? Image.file(
                                      File(user.photo!),
                                      fit: BoxFit.cover,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.2,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(
                                            Icons.image_not_supported_rounded);
                                      },
                                    )
                                  : Image.asset(
                                      Images.avatar,
                                      color: AppColor.white,
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.sizeOf(context).height /
                                              14,
                                      width:
                                          MediaQuery.sizeOf(context).width / 7,
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
                                    'Hi, ${user.name}',
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                    style: appTheme.textTheme.headlineMedium!
                                        .copyWith(
                                      color: AppColor.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    user.email,
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                    style:
                                        appTheme.textTheme.bodyMedium!.copyWith(
                                      color: AppColor.white.withOpacity(0.8),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 50,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.3,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColor.primary.withOpacity(0.1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        'Go to profile',
                                        style: appTheme.textTheme.labelMedium!
                                            .copyWith(
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
                      );
                    },
                    orElse: () {
                      return Container(
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
                                    'Hi',
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                    style: appTheme.textTheme.headlineMedium!
                                        .copyWith(
                                      color: AppColor.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'youremail@icloud.com',
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                    style:
                                        appTheme.textTheme.bodyMedium!.copyWith(
                                      color: AppColor.white.withOpacity(0.8),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 50,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.3,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppColor.primary.withOpacity(0.1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        'Go to profile',
                                        style: appTheme.textTheme.labelMedium!
                                            .copyWith(
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
                      );
                    },
                  );
                },
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
                      child: BlocBuilder<BookCubit, BookState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            loading: () {
                              return const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColor.primary,
                                  ),
                                ),
                              );
                            },
                            success: (books) {
                              return ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 16),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: books.length,
                                itemBuilder: (context, index) {
                                  final book = books[index];
                                  return NewestBookCardWidget(
                                    book: book,
                                  );
                                },
                              );
                            },
                            error: (message) {
                              return Center(
                                child: Text(
                                  message,
                                  style: appTheme.textTheme.bodyMedium!
                                      .copyWith(color: AppColor.textSecondary),
                                ),
                              );
                            },
                            orElse: () {
                              return Center(
                                child: Text(
                                  'Failed to get newest books',
                                  style: appTheme.textTheme.bodyMedium!
                                      .copyWith(color: AppColor.textSecondary),
                                ),
                              );
                            },
                          );
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
                      valueListenable: selectedGenre,
                      builder: (context, value, _) {
                        return SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.035,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: genres.length,
                            itemBuilder: (context, index) {
                              final category = genres[index];
                              final isSelected = value == category;
                              return CategoryWidget(
                                selectedCategory: selectedGenre,
                                category: category,
                                isSelected: isSelected,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<QueryBookCubit, QueryBookState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          error: (message) {
                            return Center(
                              child: Text(
                                message,
                                style: appTheme.textTheme.bodyMedium!
                                    .copyWith(color: AppColor.textSecondary),
                              ),
                            );
                          },
                          loading: () {
                            return const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.primary,
                                ),
                              ),
                            );
                          },
                          success: (books) {
                            return books.isEmpty
                                ? Center(
                                    child: Text(
                                      'No books found for this genre',
                                      style: appTheme.textTheme.bodyMedium!
                                          .copyWith(
                                              color: AppColor.textSecondary),
                                    ),
                                  )
                                : ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 8),
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: books.length,
                                    itemBuilder: (context, index) {
                                      final book = books[index];
                                      return ExploreBookCardWidget(
                                        book: book,
                                      );
                                    },
                                  );
                          },
                          orElse: () {
                            return Center(
                              child: Text(
                                'Failed to get explore books',
                                style: appTheme.textTheme.bodyMedium!
                                    .copyWith(color: AppColor.textSecondary),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.085),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadBookScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        backgroundColor: AppColor.primary,
        label: Text(
          'Upload Book',
          style: appTheme.textTheme.labelMedium!.copyWith(
            color: AppColor.white,
          ),
        ),
      ),
    );
  }
}
