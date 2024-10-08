import 'package:e_library/data/datasources/book_local_datasource.dart';
import 'package:e_library/data/models/book_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_state.dart';
part 'book_cubit.freezed.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(const BookState.initial());

  Future<void> getNewestBooks() async {
    emit(const BookState.loading());
    try {
      final books = await BookLocalDatasource.instance.getNewestBooks();
      emit(BookState.success(books));
    } catch (e) {
      emit(BookState.error('Failed to get newest books: $e'));
    }
  }

  // Future<void> getExploreBooks() async {
  //   emit(const BookState.loading());
  //   try {
  //     final books = await BookLocalDatasource.instance.getBooks();
  //     emit(BookState.success(books));
  //   } catch (e) {
  //     emit(BookState.error('Failed to get explore books: $e'));
  //   }
  // }

  // Future<void> getExploreBooks(String genre) async {
  //   emit(const BookState.loading());
  //   try {
  //     final books = await BookLocalDatasource.instance.getBooksByGenre(genre);
  //     emit(BookState.success(books));
  //   } catch (e) {
  //     emit(BookState.error('Failed to get explore books: $e'));
  //   }
  // }
}
