
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

class ProfileImagePickerSuccessState extends UserState {
  final File  imageFile;

  const ProfileImagePickerSuccessState( {required this.imageFile});

  @override
  List<Object> get props => [imageFile];
}

class ProfileImagePickerErrorState extends UserState {
  final String  error;

  const ProfileImagePickerErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

