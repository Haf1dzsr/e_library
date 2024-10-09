import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/presentation/explore/screens/explore_screen.dart';
import 'package:e_library/presentation/favorite/screens/favorite_screen.dart';
import 'package:e_library/presentation/profile/screens/profile_screen.dart';
import 'package:e_library/presentation/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

class NavbarScreen extends StatelessWidget {
  NavbarScreen({super.key});

  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  final List<Widget> _pages = [
    const ExploreScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selectedIndex,
      builder: (context, value, _) {
        return Scaffold(
          backgroundColor: AppColor.white,
          body: _pages[_selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: AppColor.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex.value,
            selectedItemColor: AppColor.primary,
            onTap: _onItemTapped,
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
    );
  }
}
