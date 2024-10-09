part of 'navbar_cubit.dart';

@freezed
class NavbarState with _$NavbarState {
  const factory NavbarState.initial(int currentIndex) = _Initial;
  const factory NavbarState.changeIndex(int selectedIndex) = _ChangeIndex;
}
