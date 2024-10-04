import 'package:e_library/data/datasources/user_local_datasource.dart';
import 'package:e_library/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_new_user_state.dart';
part 'create_new_user_cubit.freezed.dart';

class CreateNewUserCubit extends Cubit<CreateNewUserState> {
  CreateNewUserCubit() : super(const CreateNewUserState.initial());

  Future<void> createNewUser({
    required UserModel user,
  }) async {
    emit(const CreateNewUserState.loading());
    try {
      await UserLocalDataSource.instance.insertUser(user);
      emit(const CreateNewUserState.success());
    } catch (e) {
      emit(CreateNewUserState.error(e.toString()));
    }
  }
}
