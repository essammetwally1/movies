import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';

class TabItem extends StatelessWidget {
  final bool isSelected;
  final String label;
  final Color selectedForegroundColor;
  final Color selectedbackgroundColor;
  final Color unselectedForegroundColor;

  const TabItem({
    super.key,
    required this.isSelected,
    required this.label,
    required this.selectedForegroundColor,
    required this.selectedbackgroundColor,
    required this.unselectedForegroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(horizontal: 19, vertical: 11),
      decoration: BoxDecoration(
        color: isSelected ? selectedbackgroundColor : AppTheme.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? selectedbackgroundColor
              : unselectedForegroundColor,
          width: 2,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? selectedForegroundColor
              : unselectedForegroundColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
