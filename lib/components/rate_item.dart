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
      width: MediaQuery.sizeOf(context).width * .29,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.grey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/$iconePath.svg',
            width: 20,
            height: 20,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              rate,
              style: Theme.of(context).textTheme.labelLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
