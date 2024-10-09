part of 'favorite_book_cubit.dart';

@freezed
class FavoriteBookState with _$FavoriteBookState {
  const factory FavoriteBookState.initial() = _Initial;
  const factory FavoriteBookState.loading() = _Loading;
  const factory FavoriteBookState.loaded(List<BookModel> books) = _Loaded;
  const factory FavoriteBookState.error(String message) = _Error;
}
