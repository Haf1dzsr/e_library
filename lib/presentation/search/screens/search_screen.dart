import 'package:e_library/common/themes/app_color.dart';
import 'package:e_library/common/themes/app_theme.dart';
import 'package:e_library/common/widgets/custom_textformfield.dart';
import 'package:e_library/presentation/explore/widgets/explore_book_card_widget.dart';
import 'package:e_library/presentation/search/cubits/search_book_cubit/search_book_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchC = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SearchBookCubit>().searchBooks('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.sizeOf(context).height * 0.1125),
        child: AppBar(
          title: Text(
            'Search Books',
            style: appTheme.textTheme.headlineMedium!
                .copyWith(color: AppColor.textPrimary),
          ),
          bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.sizeOf(context).height * 0.1),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: CustomTextFormField(
                textInputAction: TextInputAction.done,
                hint: 'Search Books',
                controller: searchC,
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColor.grey,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    searchC.clear();
                    context.read<SearchBookCubit>().searchBooks('');
                  },
                  icon: const Icon(Icons.clear_rounded),
                ),
                onChanged: (query) {
                  context.read<SearchBookCubit>().searchBooks(query);
                },
              ),
            ),
          ),
          backgroundColor: AppColor.white,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<SearchBookCubit, SearchBookState>(
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
                          'No books found',
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
                    'Failed to get books',
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
