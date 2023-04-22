import 'package:cep_app/models/address_model.dart';

abstract class ZipCodeRepository {
  Future<AddressModel> getCep(String zipCode);
}