import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies/app_theme.dart';

class RateItem extends StatelessWidget {
  final String iconePath;
  final String rate;
  const RateItem({super.key, required this.iconePath, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .28,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.grey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Spacer(),
          SvgPicture.asset(
            'assets/icons/$iconePath.svg',
            width: 24,
            height: 24,
          ),
          Spacer(),
          Text(rate, style: Theme.of(context).textTheme.labelLarge),
          Spacer(),
        ],
      ),
    );
  }
}
