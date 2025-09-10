import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavbarIcon extends StatelessWidget {
  final String iconName;
  const NavbarIcon({super.key, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/navbar_icons/$iconName.svg',
      width: 26,
      height: 26,
      fit: BoxFit.scaleDown,
    );
  }
}
