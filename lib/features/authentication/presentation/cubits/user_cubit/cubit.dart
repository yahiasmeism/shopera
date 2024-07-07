import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:shopera/core/errors/failures.dart';
import 'package:shopera/features/authentication/domain/entities/user.dart';
import 'package:shopera/features/authentication/domain/usecases/login.dart';
import 'package:shopera/features/authentication/domain/usecases/register.dart';
import 'package:shopera/features/authentication/domain/usecases/update_user.dart';
part 'states.dart';

class UserCubit extends Cubit<UserState> {
  User? userEntite ;
  final LoginUsecase getLogin;
  final  RegisterUsecase getRegister;
  final UpdateUsecase putUser;
  UserCubit({required this.getLogin , required this.getRegister ,required this.putUser}) : super(UserInitial());


  Future<void> loginUser(
      {required String username, required String password , bool isFromGoogle =false}) async {
    // Add login logic here (e.g., API call)
    if(isFromGoogle) {
      emit(UserLoading());
    }

    // Simulate a successful login
    final failureOrLogin = await getLogin(username, password);

    emit(_mapFailureOrUserToState(failureOrLogin));
  }



  Future<void> registerUser(
     {required String username, required String email, required String password, bool isFromGoogle =false}) async {
    // Add register logic here (e.g., API call)
    if(isFromGoogle) {
      emit(UserLoading());
    }

    // Simulate a successful register
    final failureOrRegister = await getRegister(username,email, password);

    emit(_mapFailureOrUserToState(failureOrRegister));
  }



   Future<void> updateUser(
     {required User user}) async {
   
      emit(UserLoading());

    // Simulate a successful update
    final failureOrUpdated = await putUser(user);

    emit(_mapFailureOrUserToState(failureOrUpdated));

  }


  UserState _mapFailureOrUserToState(Either<Failure, User> either) {
    return either.fold(
        (failure) => UserFailure(error: failure.message),
        (user) {
          userEntite = user;
          return UserSuccess(user: user);

        } 
        );
  }

}
