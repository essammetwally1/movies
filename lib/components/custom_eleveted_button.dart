import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/app_theme.dart';

class CustomElevatedButton extends StatelessWidget {
  final String? textElevatedButton;
  final String? iconPath;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color color;
  final TextStyle? textStyle;
  const CustomElevatedButton({
    super.key,
    this.textElevatedButton,
    required this.onPressed,
    this.isLoading = false,
    this.color = AppTheme.primary,
    this.textStyle,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        fixedSize: Size(MediaQuery.sizeOf(context).width, 56),
      ),
      onPressed: onPressed,
      child: isLoading
          ? Center(child: CircularProgressIndicator(color: AppTheme.white))
          : textElevatedButton == null
          ? SvgPicture.asset('assets/icons/${iconPath}.svg')
          : textElevatedButton == 'Login With Google'
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'G',
                  style:
                      textStyle ??
                      TextTheme.of(context).titleLarge!.copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(width: 10),
                Text(
                  textElevatedButton!,
                  style: textStyle ?? TextTheme.of(context).titleLarge,
                ),
              ],
            )
          : Text(
              textElevatedButton!,
              style: textStyle ?? TextTheme.of(context).titleLarge,
            ),
    );
  }
}
