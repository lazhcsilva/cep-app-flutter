import 'package:cep_app/models/address_model.dart';
import 'package:cep_app/repositories/zipcode_repository.dart';
import 'package:cep_app/repositories/zipcode_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  const HomePage({ super.key });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  final ZipCodeRepository zipCodeRepository = ZipCodeRepositoryImpl();
  AddressModel? addressModel;
  bool loaging = false;

  final formKey = GlobalKey<FormState>();
  final zipEC = TextEditingController();

  @override
  void dispose() {
    zipEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Zip Code'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: zipEC,
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return 'Zip Code is required';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    final valid = formKey.currentState?.validate() ?? false;
                    if(valid) {
                      try {
                        setState(() {
                          loaging = true;
                        });
                        final addressReturn = await zipCodeRepository.getZip(zipEC.text);
                        setState(() {
                          loaging = false;
                          addressModel = addressReturn;
                        });
                      } catch (e) {
                        setState(() {
                          loaging = false;
                          addressModel = null;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Error when searching for zip code')),
                        );
                      }
                    }
                  },
                  child: const Text('Search'),
              ),
              Visibility(
                  visible: loaging == true,
                  child: const CircularProgressIndicator(),
              ),
              Visibility(
                  visible: addressModel != null,
                  child: Table(
                    defaultColumnWidth: const FixedColumnWidth(270.0),
                    border: const TableBorder(
                      horizontalInside: BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      verticalInside: BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                    ),
                    children: [
                      _createLineTable("Logradouro, ${addressModel?.logradouro}"),
                      _createLineTable("Complemento, ${addressModel?.complemento}"),
                      _createLineTable("Bairro, ${addressModel?.bairro}"),
                      _createLineTable("Cidade, ${addressModel?.localidade}"),
                      _createLineTable("Estado, ${addressModel?.uf}"),
                      _createLineTable("CEP, ${addressModel?.cep}")
                    ],
                  ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  _createLineTable(String listNames){
    return TableRow(
      children: listNames.split(',').map((name) {
        return Container(
          alignment: Alignment.center,
          child: Text(
            name,
            style: TextStyle(fontSize: 20.0),
          ),
          padding: EdgeInsets.all(8.0),
        );
      }).toList(),
    );
  }

}