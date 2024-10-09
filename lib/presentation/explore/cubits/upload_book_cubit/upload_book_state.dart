part of 'upload_book_cubit.dart';

@freezed
class UploadBookState with _$UploadBookState {
  const factory UploadBookState.initial() = _Initial;
  const factory UploadBookState.loading() = _Loading;
  const factory UploadBookState.success() = _Success;
  const factory UploadBookState.imagePicked(File image) = _ImagePicked;
  const factory UploadBookState.filePicked(File file) = _FilePicked;
  const factory UploadBookState.imageNotPicked(String message) =
      _ImageNotPicked;
  const factory UploadBookState.fileNotPicked(String message) = _FileNotPicked;
  const factory UploadBookState.error(String message) = _Error;
}
