import 'package:e_library/data/datasources/book_local_datasource.dart';
import 'package:e_library/data/models/book_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_book_state.dart';
part 'query_book_cubit.freezed.dart';

class QueryBookCubit extends Cubit<QueryBookState> {
  QueryBookCubit() : super(const QueryBookState.initial());

  Future<void> getExploreBooks(String genre) async {
    emit(const QueryBookState.loading());
    try {
      final books = await BookLocalDatasource.instance.getBooksByGenre(genre);
      emit(QueryBookState.success(books));
    } catch (e) {
      emit(QueryBookState.error('Failed to get explore books: $e'));
    }
  }
}
