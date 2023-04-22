import 'dart:convert';

class AddressModel {
  final String zipCode;
  final String address;
  final String complement;
  final String neighborhood;
  final String city;
  final String state;

  AddressModel({
    required this.zipCode,
    required this.address,
    required this.complement,
    required this.neighborhood,
    required this.city,
    required this.state,
  });

  Map<String, dynamic> toMap(){
    return {
      'zipCode': zipCode,
      'address': address,
      'complement': complement,
      'neighborhood': neighborhood,
      'city': city,
      'state': state,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map){
    return AddressModel(
      zipCode: map['zipCode'] ?? '',
      address: map['address'] ?? '',
      complement: map['complement'] ?? '',
      neighborhood: map['neigborhood'] ?? '',
      city: map['city'] ?? '',
      state: map['map'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source));

}