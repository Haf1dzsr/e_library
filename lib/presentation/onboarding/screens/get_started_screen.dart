import 'package:e_library/common/constants/validators.dart';
import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/common/widgets/custom_textformfield.dart';
import 'package:e_library/presentation/navbar/screens/navbar_screen.dart';
import 'package:flutter/material.dart';

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
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavbarScreen(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Take me in',
                        style: appTheme.textTheme.labelMedium!
                            .copyWith(color: AppColor.white),
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
