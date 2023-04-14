import 'package:flutter_modular/flutter_modular.dart';
import 'package:validar_cpf_cnpj/controller/cnpj-controller.dart';
import 'package:validar_cpf_cnpj/pages/cnpj_page.dart';

class SingleModule extends Module {
  @override
  List<Bind<Object>> get binds => [Bind.singleton((i) => CNPJController())];

  @override
  // TODO: implement routes
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: (context, args) => CNPJPage())];
}
