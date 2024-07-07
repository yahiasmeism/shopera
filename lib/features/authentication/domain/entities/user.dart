import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';


 class User extends Equatable {
  final int id;
  final String? firstName;
  final String? lastName;
  final String userName;
  final String? image;
  final String email;
  final String? phone;
  final String? token;
  final Address? address;

  const User( {required this.userName, required this.image,required this.id, required this.firstName,  required this.lastName,required this.email, required this.phone, required this.address, required this.token});

  @override
  List<Object?> get props => [id, firstName, lastName,userName, image ,email,phone , address];
}
