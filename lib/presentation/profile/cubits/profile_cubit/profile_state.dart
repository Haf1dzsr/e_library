part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded(UserModel user) = _Loaded;
  const factory ProfileState.success() = _Success;
  const factory ProfileState.imagePicked(File image) = _ImagePicked;
  const factory ProfileState.imageNotPicked(String message) = _ImageNotPicked;
  const factory ProfileState.error(String message) = _Error;
}
