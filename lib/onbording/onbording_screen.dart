import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/onbording/onbording_data_model.dart';

class OnbordingScreen extends StatelessWidget {
  final OnbordingDataModel onbordingData;
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final int index;

  OnbordingScreen({
    required this.onbordingData,
    this.onNext,
    this.onBack,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: screenSize.height,
            width: double.infinity,
            child: Image.asset(
              "assets/images/${onbordingData.imageBath}.png",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                color: AppTheme.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    onbordingData.title,
                    style: textTheme.titleLarge?.copyWith(
                      color: AppTheme.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    onbordingData.description,
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium?.copyWith(
                      color: AppTheme.white,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 32),

                  if (index == 0)
                    _buildMainButton("Explore Now", onNext)
                  else if (index == 1)
                    _buildMainButton("Next", onNext)
                  else
                    Column(
                      children: [
                        _buildMainButton(
                          onbordingData.isLast ? "Finish" : "Next",
                          onNext,
                        ),
                        SizedBox(height: 12),
                        _buildBackButton("Back", onBack),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainButton(String text, VoidCallback? onTap) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: AppTheme.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildBackButton(String text, VoidCallback? onTap) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.primary,
          side: BorderSide(color: AppTheme.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
