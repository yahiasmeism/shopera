// ignore_for_file: must_be_immutable, annotate_overrides, overridden_fields

import 'package:hive/hive.dart';
import 'package:shopera/features/authentication/domain/entities/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends User with HiveObjectMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String? firstName;
  @HiveField(2)
  final String? lastName;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String? phone;
  @HiveField(5)
  final String? image;
  @HiveField(6)
  final Address? address;
 @HiveField(7)
  final String username;
 @HiveField(8)
  final String? token;


  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phone,
    required this.image,
    required this.address,
    required this.token,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          userName:username,
          image: image,
          email: email,
          phone: phone,
          address: address,
          token: token,

        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'] ,
      token: json['token'] ,
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username':username,
      'email': email,
      'phone': phone,
      'image': image,
      'token': token,
      'address': address?.toJson() ,
    };
  }
    factory UserModel.fromEntity(User userEntity) {
    return UserModel(
      id: userEntity.id,
      firstName: userEntity.firstName,
      lastName: userEntity.lastName,
      username: userEntity.userName,
      email: userEntity.email,
      phone: userEntity.phone,
      image: userEntity.image,
      token: userEntity.token,
      address: userEntity.address != null ? Address.fromEntity(userEntity.address!) : null,
    );
  }
}

@HiveType(typeId: 1)
class Address extends HiveObject {
  @HiveField(0)
  final String address;
  @HiveField(1)
  final String city;
  @HiveField(2)
  final Coordinates coordinates;
  @HiveField(3)
  final String postalCode;
  @HiveField(4)
  final String state;

  Address({
    required this.address,
    required this.city,
    required this.coordinates,
    required this.postalCode,
    required this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      city: json['city'],
      coordinates: Coordinates.fromJson(json['coordinates']),
      postalCode: json['postalCode'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'coordinates': coordinates.toJson(),
      'postalCode': postalCode,
      'state': state,
    };
  }

 factory Address.fromEntity(Address? addressEntity){
  return Address(
    address: addressEntity?.address??"" ,
    city: addressEntity?.city??"" ,
    coordinates:  Coordinates.fromEntity(addressEntity!.coordinates),
    postalCode: addressEntity.postalCode,
    state:addressEntity.state  ,
  );
 }

}

@HiveType(typeId: 2)
class Coordinates extends HiveObject {
  @HiveField(0)
  final double lat;
  @HiveField(1)
  final double lng;

  Coordinates({required this.lat, required this.lng});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: json['lat'] ??0,
      lng: json['lng']??0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
  


  factory Coordinates.fromEntity(Coordinates coordinatesEntity) {
      return Coordinates(
        lat: coordinatesEntity.lat, 
        lng: coordinatesEntity.lng
        );
  }

}
