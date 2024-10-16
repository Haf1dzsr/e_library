import 'package:e_library/common/constants/validators.dart';
import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/common/widgets/custom_textformfield.dart';
import 'package:e_library/data/datasources/user_local_datasource.dart';
import 'package:e_library/data/models/user_model.dart';
import 'package:e_library/presentation/navbar/screens/navbar_screen.dart';
import 'package:e_library/presentation/onboarding/cubits/cubit/create_new_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetStartedScreen extends StatelessWidget {
  GetStartedScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),
                  Text(
                    'Welcome to e-Library',
                    style: appTheme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore your favorite books and read them for free',
                    style: appTheme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please enter your name and email to continue',
                    style: appTheme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 36),
                  CustomTextFormField(
                    textInputAction: TextInputAction.next,
                    label: 'Name',
                    hint: 'Enter your name',
                    controller: nameC,
                    validator: Validator.nameValidator,
                  ),
                  const SizedBox(height: 12),
                  CustomTextFormField(
                    textInputAction: TextInputAction.next,
                    label: 'E-mail',
                    hint: 'Enter your email',
                    controller: emailC,
                    validator: Validator.emailValidator,
                  ),
                  const SizedBox(height: 36),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        final UserModel user = UserModel(
                          name: nameC.text,
                          email: emailC.text,
                          age: 0,
                          profession: '',
                          cityAddress: '',
                          photo: '',
                        );

                        List<UserModel> users =
                            await UserLocalDataSource.instance.getUsers();
                        if (context.mounted) {
                          if (users.isNotEmpty) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NavbarScreen(),
                              ),
                            );
                            nameC.clear();
                            emailC.clear();
                          }
                          if (formKey.currentState!.validate()) {
                            context
                                .read<CreateNewUserCubit>()
                                .createNewUser(user: user);
                          }
                        }
                      },
                      child:
                          BlocConsumer<CreateNewUserCubit, CreateNewUserState>(
                        listener: (context, state) {
                          state.maybeWhen(
                            success: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavbarScreen(),
                                ),
                              );
                              nameC.clear();
                              emailC.clear();
                            },
                            error: (message) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColor.error,
                                  content: Text(
                                    'Something went wrong $message',
                                    style: appTheme.textTheme.labelMedium!
                                        .copyWith(color: AppColor.white),
                                  ),
                                ),
                              );
                            },
                            orElse: () {},
                          );
                        },
                        builder: (context, state) {
                          return state.maybeWhen(
                            loading: () {
                              return const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                    AppColor.white,
                                  ),
                                ),
                              );
                            },
                            orElse: () {
                              return Text(
                                'Take me in',
                                style: appTheme.textTheme.labelMedium!.copyWith(
                                  color: AppColor.white,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
