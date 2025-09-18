import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/onbording/onbording_data_model.dart';
import 'package:movies/onbording/onbording_screen.dart';

class Onbording extends StatefulWidget {
  static const String routeName = "/onboarding";

  const Onbording({super.key});

  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.black,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: OnbordingDataModel.onboringList.length,
              itemBuilder: (context, index) {
                final data = OnbordingDataModel.onboringList[index];
                return OnbordingScreen(
                  index: index,
                  onbordingData: data,
                  onNext: () {
                    if (data.isLast) {
                      Navigator.pushReplacementNamed(context, "/login");
                    } else {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  onBack: index == 0
                      ? null
                      : () {
                          _controller.previousPage(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 20, top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                OnbordingDataModel.onboringList.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? AppTheme.primary
                        : AppTheme.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
