import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/presentation/explore/screens/explore_screen.dart';
import 'package:e_library/presentation/favorite/screens/favorite_screen.dart';
import 'package:e_library/presentation/navbar/cubits/navbar_cubit/navbar_cubit.dart';
import 'package:e_library/presentation/profile/screens/profile_screen.dart';
import 'package:e_library/presentation/search/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavbarScreen extends StatelessWidget {
  NavbarScreen({super.key});

  final List<Widget> _pages = [
    const ExploreScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, NavbarState>(
      builder: (context, state) {
        return state.maybeWhen(
          changeIndex: (selectedIndex) {
            return Scaffold(
              backgroundColor: AppColor.white,
              body: _pages[selectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: AppColor.white,
                type: BottomNavigationBarType.fixed,
                currentIndex: selectedIndex,
                selectedItemColor: AppColor.primary,
                onTap: (index) {
                  context.read<NavbarCubit>().changeIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shelves),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search_rounded),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.book_outlined),
                    label: 'Favorite',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_3_outlined),
                    label: 'Profile',
                  ),
                ],
              ),
            );
          },
          orElse: () {
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
