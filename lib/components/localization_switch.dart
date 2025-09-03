import 'package:flutter/material.dart';

class LocalizationSwitch extends StatefulWidget {
  final Function(bool isEnglish)? onChanged; // callback

  const LocalizationSwitch({super.key, this.onChanged});

  @override
  State<LocalizationSwitch> createState() => _LocalizationSwitchState();
}

class _LocalizationSwitchState extends State<LocalizationSwitch> {
  bool isEnglish = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEnglish = !isEnglish;
        });
        widget.onChanged?.call(isEnglish);
      },
      child: Container(
        width: 120,
        height: 55,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.amber, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _flagCircle("assets/LR.png", isEnglish),
            _flagCircle("assets/Eg.png", !isEnglish),
          ],
        ),
      ),
    );
  }

  Widget _flagCircle(String assetPath, bool isSelected) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: isSelected ? Border.all(color: Colors.amber, width: 4) : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(assetPath, fit: BoxFit.fill),
    );
  }
}
