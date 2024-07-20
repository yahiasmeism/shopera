import 'dart:io';
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:shopera/core/usecases/usecase.dart';
import 'package:shopera/features/authentication/domain/usecases/get_current_user_usecase.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/login.dart';
import '../../../domain/usecases/logout.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/usecases/register.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domain/usecases/update_user.dart';
import 'package:shopera/features/authentication/presentation/pages/login_page.dart';

part 'states.dart';

class UserCubit extends Cubit<UserState> {
  User? userEntite;
  final LoginUsecase getLogin;
  final RegisterUsecase getRegister;
  final UpdateUsecase putUser;
  final LogoutUseCase logout;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  UserCubit({
    required this.getCurrentUserUsecase,
    required this.getLogin,
    required this.getRegister,
    required this.putUser,
    required this.logout,
  }) : super(UserInitial());

  Future<void> signInUser({required String username, required String password, bool isFromGoogle = false}) async {
    // Add login logic here (e.g., API call)
    if (!isFromGoogle) {
      emit(UserLoading());
    }

    // Simulate a successful login
    final failureOrLogin = await getLogin(username, password);

    emit(_mapFailureOrUserToState(failureOrLogin));
  }

  Future<void> registerUser(
      {required String username, required String email, required String password, bool isFromGoogle = false}) async {
    // Add register logic here (e.g., API call)
    if (!isFromGoogle) {
      emit(UserLoading());
    }

    // Simulate a successful register
    final failureOrRegister = await getRegister(username, email, password);

    emit(_mapFailureOrUserToState(failureOrRegister));
  }

  Future<void> updateUser({required User user}) async {
    emit(UserLoading());

    // Simulate a successful update
    final failureOrUpdated = await putUser(user);

    emit(_mapFailureOrUserToState(failureOrUpdated));
  }

  Future<void> logoutUser(BuildContext context) async {
    logout().then((onValue) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        SignInPage.routeName,
        (route) => false,
      );
    });
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickerFile != null) {
      //  File(pickerFile.path);
      emit(ProfileImagePickerSuccessState(
        imageFile: File(pickerFile.path),
      ));
    } else {
      if (kDebugMode) {
        print("No image selected");
      }
      emit(const ProfileImagePickerErrorState(error: 'Error image selected'));
    }
  }

  UserState _mapFailureOrUserToState(Either<Failure, User> either) {
    return either.fold((failure) => UserFailure(error: failure.message), (user) {
      userEntite = user;
      return UserSuccess(user: user);
    });
  }

  Future getCurrentUser() async {
    final result = await getCurrentUserUsecase(NoParams());
    result.fold(
      (failure) {},
      (user) {
        userEntite = user;
      },
    );

    return userEntite;
  }
}
