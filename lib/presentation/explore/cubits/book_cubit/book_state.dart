part of 'book_cubit.dart';

@freezed
class BookState with _$BookState {
  const factory BookState.initial() = _Initial;
  const factory BookState.loading() = _Loading;
  const factory BookState.success(List<BookModel> books) = _Success;
  const factory BookState.error(String message) = _Error;
}
