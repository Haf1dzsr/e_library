import 'package:e_library/data/datasources/book_local_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_book_to_favorite_state.dart';
part 'add_book_to_favorite_cubit.freezed.dart';

class AddBookToFavoriteCubit extends Cubit<AddBookToFavoriteState> {
  AddBookToFavoriteCubit() : super(const AddBookToFavoriteState.initial());

  Future<void> addFavoriteBook(int id, int value) async {
    emit(const AddBookToFavoriteState.loading());
    try {
      await BookLocalDatasource.instance.addFavoriteBook(id, value);
      emit(const AddBookToFavoriteState.success());
    } catch (e) {
      emit(
          const AddBookToFavoriteState.error('Failed to add book to favorite'));
    }
  }
}
