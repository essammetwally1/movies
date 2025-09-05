import 'package:flutter/material.dart';

class MovieShotsSection extends StatelessWidget {
  final List<String> shots = [
    'assets/images/shot1.png',
    'assets/images/shot2.png',
    'assets/images/shot3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: shots.map((shot) {
        return Container(
          margin: EdgeInsets.only(bottom: 5),
          height: MediaQuery.sizeOf(context).height * .2,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: .2),
                blurRadius: 8,
              ),
            ],
            image: DecorationImage(image: AssetImage(shot), fit: BoxFit.cover),
          ),
        );
      }).toList(),
    );
  }
}
