import 'package:e_library/data/datasources/book_local_datasource.dart';
import 'package:e_library/data/models/book_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_detail_state.dart';
part 'book_detail_cubit.freezed.dart';

class BookDetailCubit extends Cubit<BookDetailState> {
  BookDetailCubit() : super(const BookDetailState.initial());

  Future<void> getBookDetailById(int id) async {
    emit(const BookDetailState.loading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final book = await BookLocalDatasource.instance.getBook(id);

      emit(BookDetailState.loaded(book));
    } catch (e) {
      emit(const BookDetailState.error('Failed to load book detail'));
    }
  }

  Future<void> refresh(int id) async {
    try {
      final book = await BookLocalDatasource.instance.getBook(id);

      emit(BookDetailState.loaded(book));
    } catch (e) {
      emit(const BookDetailState.error('Failed to load book detail'));
    }
  }
}
