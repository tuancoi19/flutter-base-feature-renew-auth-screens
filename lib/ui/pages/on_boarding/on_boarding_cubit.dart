import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/database/share_preferences_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'on_boarding_navigator.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingNavigator navigator;

  OnBoardingCubit({
    required this.navigator,
  }) : super(const OnBoardingState());

  void onPageChanged(int currentIndex) {
    emit(state.copyWith(activePage: currentIndex));
  }

  void setTotalPage({required int totalPage}) {
    emit(state.copyWith(totalPage: totalPage));
  }

  void onNextPage({
    required int nextPage,
    required BuildContext context,
  }) {
    if (nextPage < state.totalPage) {
      emit(state.copyWith(activePage: nextPage));
    } else {
      SharedPreferencesHelper.setOnboard();
      navigator.openSignInPage();
    }
  }
}
