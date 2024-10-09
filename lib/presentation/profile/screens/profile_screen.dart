import 'dart:io';

import 'package:e_library/common/constants/images.dart';
import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/presentation/onboarding/screens/get_started_screen.dart';
import 'package:e_library/presentation/profile/cubits/profile_cubit/profile_cubit.dart';
import 'package:e_library/presentation/profile/widgets/edit_profile_info_dialog_widget.dart';
import 'package:e_library/presentation/profile/widgets/profile_info_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getUserProfile();
  }

  File? profilePhoto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: appTheme.textTheme.headlineMedium!
              .copyWith(color: AppColor.white),
        ),
        actions: [
          BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              state.maybeWhen(
                success: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GetStartedScreen(),
                    ),
                  );
                },
                error: (message) {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text(
                          'Logout Failed',
                          style: appTheme.textTheme.bodyMedium!
                              .copyWith(color: AppColor.textPrimary),
                        ),
                        content: Text(message),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                orElse: () {},
              );
            },
            child: IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text(
                          'Are you sure you want to logout?\nLogout will remove all your data.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: appTheme.textTheme.labelMedium!.copyWith(
                              color: AppColor.textSecondary,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            context.read<ProfileCubit>().logout();
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Logout',
                            style: appTheme.textTheme.labelMedium!.copyWith(
                              color: AppColor.error,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.logout_rounded,
                color: AppColor.white,
              ),
            ),
          ),
        ],
        backgroundColor: AppColor.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColor.primary,
                  ),
                ),
              );
            },
            loaded: (user) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: AppColor.primary,
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: ClipOval(
                              child: user.photo != ''
                                  ? Image.file(
                                      File(user.photo!),
                                      fit: BoxFit.cover,
                                      width:
                                          MediaQuery.sizeOf(context).width / 3,
                                    )
                                  : Image.asset(
                                      Images.avatar,
                                      color: AppColor.white,
                                      fit: BoxFit.cover,
                                      width:
                                          MediaQuery.sizeOf(context).width / 3,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {
                              context.read<ProfileCubit>().pickImage();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColor.primary.withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: BlocConsumer<ProfileCubit, ProfileState>(
                              listener: (context, state) {
                                state.maybeWhen(
                                  imagePicked: (image) {
                                    context
                                        .read<ProfileCubit>()
                                        .updateUserProfilePhoto(
                                            image.path, user.id!);
                                  },
                                  orElse: () {},
                                );
                              },
                              builder: (context, state) {
                                return state.maybeWhen(
                                  loading: () {
                                    return const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColor.primary,
                                      ),
                                    );
                                  },
                                  orElse: () {
                                    return Text(
                                      'Change Profile Picture',
                                      style: appTheme.textTheme.labelMedium!
                                          .copyWith(color: AppColor.white),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user.name,
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            style: appTheme.textTheme.headlineMedium!
                                .copyWith(color: AppColor.white),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email,
                            style: appTheme.textTheme.bodyMedium!.copyWith(
                                color: AppColor.white.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        ProfileInfoTileWidget(
                            title: 'Age',
                            value: user.age != 0 ? user.age.toString() : ''),
                        ProfileInfoTileWidget(
                            title: 'Profession', value: user.profession ?? ''),
                        ProfileInfoTileWidget(
                            title: 'City Address',
                            value: user.cityAddress ?? ''),
                      ],
                    ),
                  ],
                ),
              );
            },
            error: (message) {
              return Center(
                child: Text(
                  message,
                  style: appTheme.textTheme.bodyMedium!
                      .copyWith(color: AppColor.textSecondary),
                ),
              );
            },
            orElse: () {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: AppColor.primary,
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: ClipOval(
                              child: Image.asset(
                                Images.avatar,
                                color: AppColor.white,
                                fit: BoxFit.cover,
                                width: MediaQuery.sizeOf(context).width / 3,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColor.primary.withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Change Profile Picture',
                              style: appTheme.textTheme.labelMedium!
                                  .copyWith(color: AppColor.white),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Hafidz Surya Ramadhan',
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            style: appTheme.textTheme.headlineMedium!
                                .copyWith(color: AppColor.white),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'hafidzsr@icloud.com',
                            style: appTheme.textTheme.bodyMedium!.copyWith(
                                color: AppColor.white.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Column(
                      children: [
                        ProfileInfoTileWidget(title: 'Age', value: '24'),
                        ProfileInfoTileWidget(
                            title: 'Profession', value: 'Software Engineer'),
                        ProfileInfoTileWidget(
                            title: 'City Address', value: 'Cirebon'),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (user) {
                  return FloatingActionButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return EditProfileInfoDialogWidget(
                            user: user,
                          );
                        },
                      );
                    },
                    backgroundColor: AppColor.primary,
                    child: Text(
                      'Edit Profile Information',
                      style: appTheme.textTheme.labelMedium!.copyWith(
                        color: AppColor.white,
                      ),
                    ),
                  );
                },
                orElse: () {
                  return FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: AppColor.primary,
                    child: Text(
                      'Edit Profile Information',
                      style: appTheme.textTheme.labelMedium!.copyWith(
                        color: AppColor.white,
                      ),
                    ),
                  );
                },
              );
            },
          )),
    );
  }
}
