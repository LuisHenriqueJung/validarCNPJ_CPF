import 'package:brasil_fields/brasil_fields.dart';

class AppValidator {
  String? cpfValidator(String? cpf) {
    cpf?.replaceAll(RegExp(r"[^0-9]"), "");
    if (!CPFValidator.isValid(cpf)) {
      return 'CPF incorreto!';
    } else {
      return null;
    }
  }

  String? cnpjValidator(String? cnpj) {
    cnpj?.replaceAll(RegExp(r"[^0-9]"), "");
    if (!CNPJValidator.isValid(cnpj)) {
      return 'CNPJ incorreto!';
    } else {
      return null;
    }
  }
}
