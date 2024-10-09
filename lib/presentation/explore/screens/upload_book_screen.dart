import 'dart:io';

import 'package:e_library/common/constants/validators.dart';
import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/common/widgets/custom_dropdown.dart';
import 'package:e_library/common/widgets/custom_textformfield.dart';
import 'package:e_library/data/models/book_model.dart';
import 'package:e_library/presentation/explore/cubits/book_cubit/book_cubit.dart';
import 'package:e_library/presentation/explore/cubits/query_book_cubit/query_book_cubit.dart';
import 'package:e_library/presentation/explore/cubits/upload_book_cubit/upload_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadBookScreen extends StatelessWidget {
  UploadBookScreen({super.key});

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
          'Add New Book',
          style: appTheme.textTheme.labelLarge!.copyWith(
            color: AppColor.white,
            fontSize: 16,
          ),
        ),
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
                BlocConsumer<UploadBookCubit, UploadBookState>(
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
                              context.read<UploadBookCubit>().pickImage();
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
                BlocConsumer<UploadBookCubit, UploadBookState>(
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
                              context.read<UploadBookCubit>().pickFile();
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
        child: BlocConsumer<UploadBookCubit, UploadBookState>(
          listener: (context, state) {
            state.maybeWhen(
              success: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Book Uploaded'),
                  ),
                );
                context.read<BookCubit>().getNewestBooks();
                context.read<QueryBookCubit>().getExploreBooks('All');
                Navigator.pop(context);
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to upload book: $message'),
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
                        title: titleC.text,
                        author: authorC.text,
                        synopsis: synopsisC.text,
                        genre: selectedGenre.value,
                        pageTotal: int.parse(pageTotalC.text),
                        publishedYear: int.parse(publishedYearC.text),
                        bookCover: bookCover!.path,
                        bookFile: bookFile!.path,
                        isFavorited: false,
                      );

                      context.read<UploadBookCubit>().uploadBook(book);
                    }
                  },
                  child: Text(
                    'Add Book',
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
