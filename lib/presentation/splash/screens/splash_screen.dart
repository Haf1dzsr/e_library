import 'package:e_library/common/constants/images.dart';
import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/data/datasources/user_local_datasource.dart';
import 'package:e_library/data/models/user_model.dart';
import 'package:e_library/presentation/navbar/screens/navbar_screen.dart';
import 'package:e_library/presentation/onboarding/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        List<UserModel> users = await UserLocalDataSource.instance.getUsers();

        if (users.isNotEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NavbarScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OnboardingScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            height: MediaQuery.sizeOf(context).height,
            Images.splashBackground,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColor.primary.withOpacity(1.0),
                    AppColor.primary.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'e-Library',
              style: appTheme.textTheme.headlineLarge!.copyWith(
                color: AppColor.white.withOpacity(0.7),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'versi 1.0.0',
                    style: appTheme.textTheme.labelSmall!.copyWith(
                        color: AppColor.white.withOpacity(0.7),
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    '© 2024 Hafidzsr. All rights reserved.',
                    style: appTheme.textTheme.labelSmall!
                        .copyWith(color: AppColor.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
