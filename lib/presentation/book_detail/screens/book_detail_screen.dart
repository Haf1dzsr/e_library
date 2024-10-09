import 'dart:io';

import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/presentation/book_detail/cubits/add_book_to_favorite_cubit/add_book_to_favorite_cubit.dart';
import 'package:e_library/presentation/book_detail/cubits/book_detail_cubit/book_detail_cubit.dart';
import 'package:e_library/presentation/book_detail/widgets/info_tile_widget.dart';
import 'package:e_library/presentation/book_detail/widgets/vertical_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen({super.key, required this.id});

  final int id;

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BookDetailCubit>().getBookDetailById(widget.id);
  }

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
      body: BlocBuilder<BookDetailCubit, BookDetailState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loaded: (book) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.sizeOf(context).height * 0.09,
                  ),
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
                            InfoTileWidget(
                                title: 'Published Year',
                                value: book.publishedYear.toString()),
                            const VerticalDividerWidget(),
                            InfoTileWidget(title: 'Genre', value: book.genre),
                            const VerticalDividerWidget(),
                            InfoTileWidget(
                                title: 'Page Total',
                                value: book.pageTotal.toString()),
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
              );
            },
            orElse: () {
              return const SizedBox.shrink();
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BlocBuilder<BookDetailCubit, BookDetailState>(
        builder: (context, state) {
          return state.maybeWhen(
            loaded: (book) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocConsumer<AddBookToFavoriteCubit, AddBookToFavoriteState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        error: (message) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Something went wrong: $message'),
                              backgroundColor: AppColor.error,
                            ),
                          );
                        },
                        success: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                book.isFavorited == true
                                    ? '${book.title} has been removed from your favorite list'
                                    : '${book.title} has been added to your favorite list',
                              ),
                            ),
                          );
                          context.read<BookDetailCubit>().refresh(widget.id);
                        },
                        orElse: () {},
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () {
                          return SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.13,
                            height: MediaQuery.sizeOf(context).height * 0.06,
                            child: FloatingActionButton(
                              onPressed: () {},
                              heroTag: 'bookmark',
                              backgroundColor: AppColor.white,
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColor.primary),
                              ),
                            ),
                          );
                        },
                        orElse: () {
                          return SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.13,
                            height: MediaQuery.sizeOf(context).height * 0.06,
                            child: FloatingActionButton(
                              onPressed: () {
                                context
                                    .read<AddBookToFavoriteCubit>()
                                    .addFavoriteBook(widget.id,
                                        book.isFavorited == true ? 0 : 1);
                              },
                              heroTag: 'bookmark',
                              backgroundColor: AppColor.white,
                              child: Icon(
                                book.isFavorited
                                    ? Icons.bookmark
                                    : Icons.bookmark_border_outlined,
                                size: 24,
                                color: AppColor.primary,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.06,
                    width: MediaQuery.sizeOf(context).width * 0.775,
                    child: FloatingActionButton.extended(
                      onPressed: () {},
                      heroTag: 'startReading',
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
              );
            },
            orElse: () {
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
