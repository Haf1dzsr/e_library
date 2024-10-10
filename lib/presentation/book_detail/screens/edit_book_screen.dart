import 'dart:io';

import 'package:e_library/common/constants/validators.dart';
import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/common/widgets/custom_dropdown.dart';
import 'package:e_library/common/widgets/custom_textformfield.dart';
import 'package:e_library/data/models/book_model.dart';
import 'package:e_library/presentation/book_detail/cubits/book_detail_cubit/book_detail_cubit.dart';
import 'package:e_library/presentation/book_detail/cubits/edit_book_cubit/edit_book_cubit.dart';
import 'package:e_library/presentation/explore/cubits/book_cubit/book_cubit.dart';
import 'package:e_library/presentation/explore/cubits/query_book_cubit/query_book_cubit.dart';
import 'package:e_library/presentation/navbar/screens/navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditBookScreen extends StatefulWidget {
  EditBookScreen({
    super.key,
    required this.book,
  });

  BookModel book;

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleC = TextEditingController();

  final TextEditingController authorC = TextEditingController();

  final TextEditingController synopsisC = TextEditingController();

  final TextEditingController pageTotalC = TextEditingController();

  final TextEditingController publishedYearC = TextEditingController();

  final TextEditingController bookCoverC = TextEditingController();

  final TextEditingController bookFileC = TextEditingController();

  ValueNotifier<String> selectedGenre = ValueNotifier('-');

  List<String> genres = [
    '-',
    'Fiction',
    'Non-Fiction',
    'Horror',
    'Romance',
    'Mystery',
    'Fantasy',
    'Biography',
  ];

  File? bookCover;

  File? bookFile;

  @override
  void initState() {
    super.initState();
    titleC.text = widget.book.title;
    authorC.text = widget.book.author;
    synopsisC.text = widget.book.synopsis;
    pageTotalC.text = widget.book.pageTotal.toString();
    publishedYearC.text = widget.book.publishedYear.toString();
    selectedGenre.value = widget.book.genre;
    bookCoverC.text = widget.book.bookCover;
    bookFileC.text = widget.book.bookFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: AppColor.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Edit Book',
          style: appTheme.textTheme.labelLarge!.copyWith(
            color: AppColor.white,
            fontSize: 16,
          ),
        ),
        actions: [
          BlocConsumer<EditBookCubit, EditBookState>(
            listener: (context, state) {
              state.maybeWhen(
                bookDeleted: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Book Deleted'),
                    ),
                  );
                  context.read<BookCubit>().getNewestBooks();
                  context.read<QueryBookCubit>().getExploreBooks('All');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavbarScreen(),
                      ),
                      (route) => false);
                },
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete book: $message'),
                    ),
                  );
                },
                orElse: () {},
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return IconButton(
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      size: 24,
                      color: AppColor.white,
                    ),
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: const Text('Delete Book'),
                            content: const Text(
                              'Are you sure you want to delete this book?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                },
                                child: Text(
                                  'Cancel',
                                  style:
                                      appTheme.textTheme.labelMedium!.copyWith(
                                    color: AppColor.textSecondary,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context
                                      .read<EditBookCubit>()
                                      .deleteBook(widget.book.id!);
                                },
                                child: Text(
                                  'Yes',
                                  style:
                                      appTheme.textTheme.labelMedium!.copyWith(
                                    color: AppColor.error,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.sizeOf(context).height * 0.1,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                ValueListenableBuilder(
                  valueListenable: selectedGenre,
                  builder: (context, genreValue, child) {
                    return CustomDropdown(
                      onChanged: (value) {
                        selectedGenre.value = value!;
                      },
                      value: selectedGenre.value,
                      items: genres,
                      label: 'Genre',
                    );
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  textInputAction: TextInputAction.next,
                  label: 'Title',
                  hint: "Enter book's title",
                  controller: titleC,
                  validator: (value) => Validator.nameValidator(value),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  textInputAction: TextInputAction.next,
                  label: 'Author',
                  hint: "Enter book's author",
                  controller: authorC,
                  validator: (value) =>
                      Validator.fieldValidator(value, 'Author'),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  maxLines: 7,
                  textInputAction: TextInputAction.next,
                  label: 'Synopsis',
                  hint: "Enter book's synopsis",
                  controller: synopsisC,
                  validator: (value) =>
                      Validator.fieldValidator(value, 'Synopsis'),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  textInputAction: TextInputAction.next,
                  label: 'Page Total',
                  hint: "Enter book's page total",
                  controller: pageTotalC,
                  validator: (value) =>
                      Validator.numberValidator(value, 'Page total'),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  textInputAction: TextInputAction.done,
                  label: 'Published Year',
                  hint: "Enter book's published year",
                  controller: publishedYearC,
                  validator: (value) =>
                      Validator.numberValidator(value, 'Published year'),
                ),
                const SizedBox(height: 16),
                BlocConsumer<EditBookCubit, EditBookState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      imagePicked: (image) {
                        bookCover = image;
                        bookCoverC.text = image.path;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Book Cover Picked'),
                          ),
                        );
                      },
                      imageNotPicked: (message) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Book Cover Not Picked'),
                          ),
                        );
                      },
                      orElse: () {},
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return CustomTextFormField(
                          readOnly: true,
                          textInputAction: TextInputAction.done,
                          maxLines: 1,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.camera_alt_outlined),
                            onPressed: () {
                              context.read<EditBookCubit>().pickImage();
                            },
                          ),
                          label: 'Book Cover',
                          hint: "Enter book's cover",
                          controller: bookCoverC,
                          validator: (value) =>
                              Validator.fieldValidator(value, 'Book cover'),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                BlocConsumer<EditBookCubit, EditBookState>(
                  listener: (context, state) {
                    state.maybeWhen(
                      filePicked: (file) {
                        bookFile = file;
                        bookFileC.text = file.path;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Book File Picked'),
                          ),
                        );
                      },
                      fileNotPicked: (message) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Book File Not Picked'),
                          ),
                        );
                      },
                      orElse: () {},
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return CustomTextFormField(
                          readOnly: true,
                          textInputAction: TextInputAction.done,
                          maxLines: 1,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.file_upload),
                            onPressed: () {
                              context.read<EditBookCubit>().pickFile();
                            },
                          ),
                          label: 'Book File',
                          hint: "Enter book's file in PDF format",
                          controller: bookFileC,
                          validator: (value) =>
                              Validator.fieldValidator(value, 'Book file'),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: 50,
        child: BlocConsumer<EditBookCubit, EditBookState>(
          listener: (context, state) {
            state.maybeWhen(
              success: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Book Edited'),
                  ),
                );
                context.read<BookCubit>().getNewestBooks();
                context.read<QueryBookCubit>().getExploreBooks('All');
                context
                    .read<BookDetailCubit>()
                    .getBookDetailById(widget.book.id!);
                Navigator.pop(context);
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to edit book: $message'),
                  ),
                );
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loading: () {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColor.white),
                  ),
                );
              },
              orElse: () {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final book = BookModel(
                        id: widget.book.id,
                        title: titleC.text,
                        author: authorC.text,
                        synopsis: synopsisC.text,
                        genre: selectedGenre.value,
                        pageTotal: int.parse(pageTotalC.text),
                        publishedYear: int.parse(publishedYearC.text),
                        bookCover: bookCoverC.text,
                        bookFile: bookFileC.text,
                        isFavorited: false,
                      );

                      context
                          .read<EditBookCubit>()
                          .editBook(book, widget.book.id!);
                    }
                  },
                  child: Text(
                    'Edit Book',
                    style: appTheme.textTheme.labelMedium!.copyWith(
                      color: AppColor.white,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
