import 'package:flutter/material.dart';

class LocalizationSwitch extends StatefulWidget {
  const LocalizationSwitch({super.key});

  @override
  State<LocalizationSwitch> createState() => _LocalizationSwitchState();
}

class _LocalizationSwitchState extends State<LocalizationSwitch> {
  bool _isArabic = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isArabic = !_isArabic;
        });
      },
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: _isArabic ? Colors.blue[100] : Colors.red[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: _isArabic ? 40 : 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
            // Egypt flag (left side)
            Positioned(
              left: 8,
              top: 8,
              child: Image.asset(
                'assets/EG.png',
                width: 24,
                height: 24,
                color: _isArabic ? Colors.blue : Colors.grey,
              ),
            ),
            // UK flag (right side)
            Positioned(
              right: 8,
              top: 8,
              child: Image.asset(
                'assets/LR.png',
                width: 24,
                height: 24,
                color: _isArabic ? Colors.grey : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
