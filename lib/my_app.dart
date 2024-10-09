import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/presentation/book_detail/cubits/add_book_to_favorite_cubit/add_book_to_favorite_cubit.dart';
import 'package:e_library/presentation/book_detail/cubits/book_detail_cubit/book_detail_cubit.dart';
import 'package:e_library/presentation/explore/cubits/book_cubit/book_cubit.dart';
import 'package:e_library/presentation/explore/cubits/query_book_cubit/query_book_cubit.dart';
import 'package:e_library/presentation/explore/cubits/upload_book_cubit/upload_book_cubit.dart';
import 'package:e_library/presentation/favorite/cubits/favorite_book_cubit/favorite_book_cubit.dart';
import 'package:e_library/presentation/navbar/cubits/navbar_cubit/navbar_cubit.dart';
import 'package:e_library/presentation/onboarding/cubits/cubit/create_new_user_cubit.dart';
import 'package:e_library/presentation/profile/cubits/profile_cubit/profile_cubit.dart';
import 'package:e_library/presentation/search/cubits/search_book_cubit/search_book_cubit.dart';
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
        BlocProvider(
          create: (context) => BookDetailCubit(),
        ),
        BlocProvider(
          create: (context) => AddBookToFavoriteCubit(),
        ),
        BlocProvider(
          create: (context) => FavoriteBookCubit(),
        ),
        BlocProvider(
          create: (context) => SearchBookCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => NavbarCubit()..changeIndex(0),
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
