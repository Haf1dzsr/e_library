import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/presentation/explore/widgets/explore_book_card_widget.dart';
import 'package:e_library/presentation/favorite/cubits/favorite_book_cubit/favorite_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteBookCubit>().getFavoriteBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Books',
          style: appTheme.textTheme.headlineMedium!
              .copyWith(color: AppColor.textPrimary),
        ),
        backgroundColor: AppColor.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: BlocBuilder<FavoriteBookCubit, FavoriteBookState>(
          builder: (context, state) {
            return state.maybeWhen(
              error: (message) {
                return Center(
                  child: Text(
                    message,
                    style: appTheme.textTheme.bodyMedium!
                        .copyWith(color: AppColor.textSecondary),
                  ),
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColor.primary,
                    ),
                  ),
                );
              },
              loaded: (favoriteBooks) {
                return favoriteBooks.isEmpty
                    ? Center(
                        child: Text(
                          'No favorite books yet',
                          style: appTheme.textTheme.bodyMedium!
                              .copyWith(color: AppColor.textSecondary),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 8),
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: favoriteBooks.length,
                                itemBuilder: (context, index) {
                                  final favoriteBook = favoriteBooks[index];
                                  return ExploreBookCardWidget(
                                    book: favoriteBook,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
              },
              orElse: () {
                return Center(
                  child: Text(
                    'Failed to get explore books',
                    style: appTheme.textTheme.bodyMedium!
                        .copyWith(color: AppColor.textSecondary),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
