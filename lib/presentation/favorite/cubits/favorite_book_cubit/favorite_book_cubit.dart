import 'package:e_library/data/datasources/book_local_datasource.dart';
import 'package:e_library/data/models/book_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_book_state.dart';
part 'favorite_book_cubit.freezed.dart';

class FavoriteBookCubit extends Cubit<FavoriteBookState> {
  FavoriteBookCubit() : super(const FavoriteBookState.initial());

  Future<void> getFavoriteBooks() async {
    emit(const FavoriteBookState.loading());
    try {
      final List<BookModel> favoriteBooks =
          await BookLocalDatasource.instance.getFavoriteBooks();
      emit(FavoriteBookState.loaded(favoriteBooks));
    } catch (e) {
      emit(FavoriteBookState.error(e.toString()));
    }
  }
}
