import 'package:flutter/material.dart';
import 'package:movies/app_theme.dart';

class AvatarSection extends StatefulWidget {
  const AvatarSection({super.key});

  @override
  State<AvatarSection> createState() => _AvatarSectionState();
}

class _AvatarSectionState extends State<AvatarSection> {
  final List<String> avatarImages = [
    'assets/avatar/avatar1.png',
    'assets/avatar/avatar2.png',
    'assets/avatar/avatar3.png',
    'assets/avatar/avatar4.png',
    'assets/avatar/avatar5.png',
    'assets/avatar/avatar6.png',
    'assets/avatar/avatar7.png',
    'assets/avatar/avatar8.png',
    'assets/avatar/avatar9.png',
  ];

  int selectedIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.4);

  // Pre-cache images for better performance
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var imagePath in avatarImages) {
      precacheImage(AssetImage(imagePath), context);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.animateToPage(
        selectedIndex,
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Remove extra space
        children: [
          SizedBox(
            height: 180, // Reduced height
            child: PageView.builder(
              controller: _pageController,
              itemCount: avatarImages.length,
              onPageChanged: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return _AvatarItem(
                  controller: _pageController,
                  index: index,
                  imagePath: avatarImages[index],
                  isSelected: index == selectedIndex,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.easeInOut,
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8), // Reduced spacing
          Text(
            'Avatar',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(color: AppTheme.white),
          ),
        ],
      ),
    );
  }
}

class _AvatarItem extends StatelessWidget {
  final PageController controller;
  final int index;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const _AvatarItem({
    required this.controller,
    required this.index,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double scale = 1.0;
        double opacity = 0.6;

        if (controller.position.haveDimensions) {
          final double page = controller.page ?? index.toDouble();
          final double diff = (page - index).abs();

          scale = (1 - (diff * 0.5)).clamp(0.7, 1.0);
          opacity = (1 - (diff * 0.8)).clamp(0.4, 1.0);
        }

        return Center(
          child: Transform.scale(
            scale: isSelected ? 1.25 : scale,
            child: Opacity(opacity: isSelected ? 1.0 : opacity, child: child),
          ),
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? AppTheme.primary : Colors.transparent,
              width: isSelected ? 3.0 : 0.0,
            ),
          ),
          child: CircleAvatar(
            radius: 50,
            child: ClipOval(child: Image.asset(imagePath, fit: BoxFit.fill)),
          ),
        ),
      ),
    );
  }
}
