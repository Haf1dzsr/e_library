import 'package:e_library/data/datasources/book_local_datasource.dart';
import 'package:e_library/data/models/book_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_book_state.dart';
part 'search_book_cubit.freezed.dart';

class SearchBookCubit extends Cubit<SearchBookState> {
  SearchBookCubit() : super(const SearchBookState.initial());

  Future<void> searchBooks(String query) async {
    emit(const SearchBookState.loading());
    try {
      final List<BookModel> books =
          await BookLocalDatasource.instance.getBooksByQuery(query);
      emit(SearchBookState.loaded(books));
    } catch (e) {
      emit(SearchBookState.error(e.toString()));
    }
  }
}
