import 'dart:developer';
import 'package:e_library/common/constants/images.dart';
import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/presentation/onboarding/widgets/onboarding_widget.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  ValueNotifier currentIndex = ValueNotifier<int>(0);

  final PageController pageController = PageController();

  List<Widget> onBoardingScreens = [
    const OnboardingWidget(
        imagePath: Images.onBoardingWelcome, title: 'Welcome to the e-Library'),
    const OnboardingWidget(
        imagePath: Images.onBoardingEnjoy,
        title: 'Enjoy reading your favorite books on the go'),
  ];

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentIndex,
      builder: (context, currentIndexValue, child) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (value) {
                    currentIndex.value = value;
                  },
                  controller: pageController,
                  itemCount: onBoardingScreens.length,
                  itemBuilder: (context, index) {
                    return onBoardingScreens[index];
                  },
                ),
              ),
              Positioned(
                bottom: MediaQuery.sizeOf(context).height * 0.01,
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onBoardingScreens.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex.value == index
                              ? AppColor.secondary
                              : AppColor.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.sizeOf(context).height * 0.0325,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: MediaQuery.sizeOf(context).width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      log('Current index: ${currentIndex.value}');
                      currentIndex.value != 1
                          ? pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            )
                          : null;
                    },
                    child: Text(
                      currentIndex.value == 0 ? 'Next' : 'Get started',
                      style: appTheme.textTheme.labelMedium!
                          .copyWith(color: AppColor.primary),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
