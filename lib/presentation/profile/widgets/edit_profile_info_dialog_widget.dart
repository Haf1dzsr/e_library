import 'package:e_library/common/constants/validators.dart';
import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/common/widgets/custom_textformfield.dart';
import 'package:e_library/data/models/user_model.dart';
import 'package:e_library/presentation/profile/cubits/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileInfoDialogWidget extends StatefulWidget {
  const EditProfileInfoDialogWidget({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<EditProfileInfoDialogWidget> createState() =>
      _EditProfileInfoDialogWidgetState();
}

class _EditProfileInfoDialogWidgetState
    extends State<EditProfileInfoDialogWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController ageC = TextEditingController();
  final TextEditingController professionC = TextEditingController();
  final TextEditingController cityAddressC = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameC.text = widget.user.name;
    ageC.text = widget.user.age == 0 ? '' : widget.user.age.toString();
    professionC.text = widget.user.profession ?? '';
    cityAddressC.text = widget.user.cityAddress ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: formKey,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Edit Profile Information',
                style: appTheme.textTheme.headlineMedium!.copyWith(
                  color: AppColor.textPrimary,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                textInputAction: TextInputAction.next,
                label: 'Name',
                hint: "Enter your name",
                controller: nameC,
                validator: (value) => Validator.nameValidator(value),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                textInputAction: TextInputAction.next,
                label: 'Age',
                hint: "Enter your age",
                controller: ageC,
                validator: (value) => Validator.numberValidator(value, 'Age'),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                textInputAction: TextInputAction.next,
                label: 'Profession',
                hint: "Enter your profession",
                controller: professionC,
                validator: (value) =>
                    Validator.fieldValidator(value, 'Profession'),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                textInputAction: TextInputAction.next,
                label: 'City Address',
                hint: "Enter your city address",
                controller: cityAddressC,
                validator: (value) =>
                    Validator.fieldValidator(value, 'City Address'),
              ),
              const SizedBox(height: 24),
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
                    final UserModel user = UserModel(
                      id: widget.user.id,
                      name: nameC.text,
                      email: widget.user.email,
                      age: int.parse(ageC.text),
                      profession: professionC.text,
                      cityAddress: cityAddressC.text,
                      photo: widget.user.photo,
                    );
                    if (formKey.currentState!.validate()) {
                      context
                          .read<ProfileCubit>()
                          .updateUserProfile(user, widget.user.id!);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    'Save',
                    style: appTheme.textTheme.labelMedium!.copyWith(
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
