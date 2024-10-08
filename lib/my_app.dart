import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/presentation/explore/cubits/book_cubit/book_cubit.dart';
import 'package:e_library/presentation/explore/cubits/query_book_cubit/query_book_cubit.dart';
import 'package:e_library/presentation/explore/cubits/upload_book_cubit/upload_book_cubit.dart';
import 'package:e_library/presentation/onboarding/cubits/cubit/create_new_user_cubit.dart';
import 'package:e_library/presentation/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateNewUserCubit(),
        ),
        BlocProvider(
          create: (context) => UploadBookCubit(),
        ),
        BlocProvider(
          create: (context) => BookCubit(),
        ),
        BlocProvider(
          create: (context) => QueryBookCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
