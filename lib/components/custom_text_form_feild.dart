import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final String? iconPathName;
  final TextEditingController? controller;
  final void Function(String)? onChange;
  final VoidCallback? onPressed;
  final String? Function(String?)? validator;
  final bool isPassword;

  const CustomTextFormField({
    super.key,
    this.hintText,
    this.iconPathName,
    this.controller,
    this.onChange,
    this.validator,
    this.onPressed,
    this.isPassword = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.isPassword ? showPassword : false,

      onChanged: widget.onChange,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: AppTheme.primary,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
        hintText: widget.hintText,

        suffixIcon: widget.isPassword
            ? IconButton(
                highlightColor: Colors.transparent,
                onPressed: () {
                  showPassword = !showPassword;
                  setState(() {});
                },
                icon: showPassword
                    ? Icon(Icons.visibility_off_outlined, color: AppTheme.white)
                    : Icon(Icons.visibility_outlined, color: AppTheme.white),
              )
            : null,
        prefixIcon: widget.iconPathName == null
            ? null
            : SvgPicture.asset(
                'assets/icons/${widget.iconPathName}.svg',
                width: 24,
                height: 24,
                fit: BoxFit.scaleDown,
              ),
      ),
    );
  }
}
