part of 'add_book_to_favorite_cubit.dart';

@freezed
class AddBookToFavoriteState with _$AddBookToFavoriteState {
  const factory AddBookToFavoriteState.initial() = _Initial;
  const factory AddBookToFavoriteState.loading() = _Loading;
  const factory AddBookToFavoriteState.success() = _Success;
  const factory AddBookToFavoriteState.error(String message) = _Error;
}
