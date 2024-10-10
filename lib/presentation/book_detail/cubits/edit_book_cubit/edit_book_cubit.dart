import 'dart:io';

import 'package:e_library/data/datasources/book_local_datasource.dart';
import 'package:e_library/data/models/book_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_book_state.dart';
part 'edit_book_cubit.freezed.dart';

class EditBookCubit extends Cubit<EditBookState> {
  EditBookCubit() : super(const EditBookState.initial());

  Future<void> editBook(BookModel book, int id) async {
    emit(const EditBookState.loading());
    try {
      await BookLocalDatasource.instance.updateBook(book, id);
      emit(const EditBookState.success());
    } catch (e) {
      emit(EditBookState.error('Failed to edit book: $e'));
    }
  }

  Future<void> deleteBook(int id) async {
    emit(const EditBookState.loading());
    try {
      await BookLocalDatasource.instance.deleteBook(id);
      emit(const EditBookState.bookDeleted());
    } catch (e) {
      emit(EditBookState.error('Failed to delete book: $e'));
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        emit(EditBookState.imagePicked(File(pickedFile.path)));
      } else {
        emit(const EditBookState.imageNotPicked('Image not picked'));
      }
    } catch (e) {
      emit(EditBookState.error('Failed to pick image: $e'));
    }
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        emit(EditBookState.filePicked(File(result.files.single.path!)));
      } else {
        emit(const EditBookState.fileNotPicked('File not picked'));
      }
    } catch (e) {
      emit(EditBookState.error('Failed to pick file: $e'));
    }
  }
}
