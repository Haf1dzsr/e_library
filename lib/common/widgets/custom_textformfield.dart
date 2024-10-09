import 'package:e_library/common/themes/app_color.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final TextEditingController controller;
  final IconButton? suffixIcon;
  final Icon? prefixIcon;
  final int? maxLength;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final String? helperText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final Widget? icon;
  final bool? isError;
  final bool? readOnly;

  const CustomTextFormField({
    super.key,
    required this.textInputAction,
    this.label,
    required this.hint,
    this.validator,
    this.obscureText = false,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLength,
    this.onChanged,
    this.helperText,
    this.keyboardType,
    this.maxLines,
    this.icon,
    this.isError = false,
    this.readOnly = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late final FocusNode _focusNode;
  late final ValueNotifier<bool> _isFocused;
  late final ValueNotifier<bool> _isError;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _isFocused = ValueNotifier<bool>(false);
    _isError = ValueNotifier<bool>(false);

    _focusNode.addListener(() {
      _isFocused.value = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _isFocused.dispose();
    _isError.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isFocused,
      builder: (context, isFocused, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: _isError,
          builder: (context, isError, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.label == null
                    ? const SizedBox.shrink()
                    : Text(
                        widget.label!,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: isError || widget.isError!
                                  ? AppColor.error
                                  : isFocused
                                      ? AppColor.primary
                                      : AppColor.grey,
                            ),
                      ),
                TextFormField(
                  readOnly: widget.readOnly!,
                  controller: widget.controller,
                  obscureText: widget.obscureText!,
                  maxLength: widget.maxLength,
                  maxLines: widget.maxLines,
                  textInputAction: widget.textInputAction,
                  focusNode: _focusNode,
                  keyboardType: widget.keyboardType,
                  style: const TextStyle(
                    color: AppColor.grey,
                  ),
                  decoration: InputDecoration(
                    helperText: widget.helperText,
                    helperStyle: Theme.of(context).textTheme.bodySmall,
                    hintText: widget.hint,
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColor.grey,
                        ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColor.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColor.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isError || widget.isError!
                            ? AppColor.error
                            : isFocused
                                ? AppColor.primary
                                : AppColor.grey,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isError || widget.isError!
                            ? AppColor.error
                            : AppColor.primary,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColor.error,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppColor.error,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorStyle: const TextStyle(
                      color: AppColor.error,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: widget.suffixIcon,
                    suffixIconColor: isError || widget.isError!
                        ? AppColor.error
                        : AppColor.grey,
                    icon: widget.icon,
                  ),
                  validator: widget.validator != null
                      ? (value) {
                          _isError.value = widget.validator!(value) != null;
                          return widget.validator!(value);
                        }
                      : null,
                  onChanged: widget.onChanged != null
                      ? (value) {
                          _isError.value = widget.onChanged!(value) != null;
                          widget.onChanged!(value);
                        }
                      : null,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
