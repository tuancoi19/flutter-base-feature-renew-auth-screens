import 'package:equatable/equatable.dart';
import 'package:flutter_base/blocs/app_cubit.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/ui/pages/auth/sign_up/sign_up_navigator.dart';
import 'package:flutter_base/utils/logger.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpNavigator navigator;
  final AuthRepository authRepo;
  final UserRepository userRepo;
  final AppCubit appCubit;

  SignUpCubit({
    required this.navigator,
    required this.authRepo,
    required this.userRepo,
    required this.appCubit,
  }) : super(const SignUpState());

  void changeFullName({required String fullName}) {
    emit(state.copyWith(fullName: fullName));
  }

  void changeEmail({required String email}) {
    emit(state.copyWith(email: email));
  }

  void changePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  void changeConfirmPassword({required String confirmPassword}) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void signUp() async {
    final fullName = state.fullName;
    final email = state.email ?? '';
    final password = state.password ?? '';
    emit(state.copyWith(signUpStatus: LoadStatus.loading));
    try {
      // final result = await authRepo.signUp(email, password);
      // if (result != null) {
        navigator.openMainPage();
      // } else {
      //   emit(state.copyWith(signUpStatus: LoadStatus.failure));
      // }
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(signUpStatus: LoadStatus.failure));
    }
  }
}
