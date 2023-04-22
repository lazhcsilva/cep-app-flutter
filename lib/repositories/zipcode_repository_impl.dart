import 'dart:developer';

import 'package:cep_app/models/address_model.dart';
import 'package:dio/dio.dart';

import './zipcode_repository.dart';

class ZipCodeRepositoryImpl implements ZipCodeRepository {
  @override
  Future<AddressModel> getCep(String zipCode) async {
    try {
      final result = await Dio().get('https://viacep.com.br/ws/$zipCode/json/');
      return AddressModel.fromJson(result.data);
    } on DioError catch(e) {
      log('Error when searching for zip code', error: e);
      throw Exception('Error when searching for zip code');
    }
  }
}
