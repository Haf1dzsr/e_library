import 'dart:io';

import 'package:e_library/data/datasources/user_local_datasource.dart';
import 'package:e_library/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState.initial());

  Future<void> getUserProfile() async {
    emit(const ProfileState.loading());
    try {
      final user = await UserLocalDataSource.instance.getUser();
      if (user != null) {
        emit(ProfileState.loaded(user));
      } else {
        emit(const ProfileState.error('User not found'));
      }
    } catch (e) {
      emit(ProfileState.error('Failed to get user profile: $e'));
    }
  }

  Future<void> updateUserProfilePhoto(String photoPath, int id) async {
    emit(const ProfileState.loading());
    try {
      await UserLocalDataSource.instance.updateUserPhoto(photoPath, id);
      await getUserProfile();
    } catch (e) {
      emit(ProfileState.error('Failed to update user profile: $e'));
    }
  }

  Future<void> updateUserProfile(UserModel user, int id) async {
    emit(const ProfileState.loading());
    try {
      await UserLocalDataSource.instance.updateUser(user, id);
      await getUserProfile();
    } catch (e) {
      emit(ProfileState.error('Failed to update user profile: $e'));
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        emit(ProfileState.imagePicked(File(pickedFile.path)));
      } else {
        emit(const ProfileState.imageNotPicked('Image not picked'));
      }
    } catch (e) {
      emit(ProfileState.error('Failed to pick image: $e'));
    }
  }
}
