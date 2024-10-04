part of 'create_new_user_cubit.dart';

@freezed
class CreateNewUserState with _$CreateNewUserState {
  const factory CreateNewUserState.initial() = _Initial;
  const factory CreateNewUserState.loading() = _Loading;
  const factory CreateNewUserState.success() = _Success;
  const factory CreateNewUserState.error(String message) = _Error;
}
