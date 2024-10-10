part of 'edit_book_cubit.dart';

@freezed
class EditBookState with _$EditBookState {
  const factory EditBookState.initial() = _Initial;
  const factory EditBookState.loading() = _Loading;
  const factory EditBookState.success() = _Success;
  const factory EditBookState.bookDeleted() = _BookDeleted;
  const factory EditBookState.imagePicked(File image) = _ImagePicked;
  const factory EditBookState.filePicked(File file) = _FilePicked;
  const factory EditBookState.imageNotPicked(String message) = _ImageNotPicked;
  const factory EditBookState.fileNotPicked(String message) = _FileNotPicked;
  const factory EditBookState.error(String message) = _Error;
}
