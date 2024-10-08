import 'dart:io';

import 'package:e_library/data/datasources/book_local_datasource.dart';
import 'package:e_library/data/models/book_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
part 'upload_book_state.dart';
part 'upload_book_cubit.freezed.dart';

class UploadBookCubit extends Cubit<UploadBookState> {
  UploadBookCubit() : super(const UploadBookState.initial());

  Future<void> uploadBook(BookModel book) async {
    emit(const UploadBookState.loading());
    try {
      await BookLocalDatasource.instance.insertBook(book);
      emit(const UploadBookState.success());
    } catch (e) {
      emit(UploadBookState.error('Failed to upload book: $e'));
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        emit(UploadBookState.imagePicked(File(pickedFile.path)));
      } else {
        emit(const UploadBookState.imageNotPicked('Image not picked'));
      }
    } catch (e) {
      emit(UploadBookState.error('Failed to pick image: $e'));
    }
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        emit(UploadBookState.filePicked(File(result.files.single.path!)));
      } else {
        emit(const UploadBookState.fileNotPicked('File not picked'));
      }
    } catch (e) {
      emit(UploadBookState.error('Failed to pick file: $e'));
    }
  }
}
