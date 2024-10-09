part of 'search_book_cubit.dart';

@freezed
class SearchBookState with _$SearchBookState {
  const factory SearchBookState.initial() = _Initial;
  const factory SearchBookState.loading() = _Loading;
  const factory SearchBookState.loaded(List<BookModel> books) = _Loaded;
  const factory SearchBookState.error(String message) = _Error;
}
