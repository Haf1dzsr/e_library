import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navbar_state.dart';
part 'navbar_cubit.freezed.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(const NavbarState.initial(0));

  void changeIndex(int selectedIndex) {
    emit(NavbarState.changeIndex(selectedIndex));
  }
}
