import 'package:http/http.dart' as http;
import 'package:validar_cpf_cnpj/model/cnpj_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CNPJController {
  CNPJ cnpjData = CNPJ(
      situacao: '',
      nome: 'nome',
      fantasia: 'fantasia',
      municipio: 'municipio',
      bairro: 'bairro',
      logradouro: 'logradouro');
  getCNPJ(String cnpj) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    Uri uri = Uri.https(
      'receitaws.com.br',
      '/v1/cnpj/${cnpj}',
    );

    var response = await http.get(uri, headers: headers);
    cnpjData = CNPJ.fromJson(response.body);
    print(cnpjData.nome);
  }
}
