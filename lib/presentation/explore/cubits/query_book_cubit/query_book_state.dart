part of 'query_book_cubit.dart';

@freezed
class QueryBookState with _$QueryBookState {
  const factory QueryBookState.initial() = _Initial;
  const factory QueryBookState.loading() = _Loading;
  const factory QueryBookState.success(List<BookModel> books) = _Success;
  const factory QueryBookState.error(String message) = _Error;
}
