
part of 'cubit.dart';


abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
   final User user;

  const UserSuccess({required this.user});
}

class UserFailure extends UserState {
  final String error;

  const UserFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class ChangePasswordVisibilityState extends UserState {
  final IconData suffix;
  final bool isPassword;

  ChangePasswordVisibilityState({required this.suffix,required this.isPassword });
}
