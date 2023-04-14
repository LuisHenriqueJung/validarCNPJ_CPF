// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validar_cpf_cnpj/controller/cnpj-controller.dart';
import 'package:validar_cpf_cnpj/validator/app_validator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CNPJPage extends StatefulWidget {
  CNPJPage({super.key});

  @override
  State<CNPJPage> createState() => _CNPJPageState();
}

class _CNPJPageState extends State<CNPJPage> {
  bool isCPF = false;
  bool isFull = false;
  CNPJController myController = Modular.get<CNPJController>();
  WebViewController viewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url
              .startsWith('https://pub.dev/packages/webview_flutter')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(
        'https://servicos.receita.fazenda.gov.br/Servicos/CPF/consultaSituacao/ConsultaPublica.asp'));

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    viewController.enableZoom(true);
    return Scaffold(
      appBar: AppBar(
        actions: [
          (isCPF)
              ? IconButton(
                  onPressed: () => viewController.goBack(),
                  icon: Icon(Icons.arrow_back))
              : Container(),
          IconButton(
              onPressed: () {
                setState(() {
                  isCPF = !isCPF;
                });
              },
              icon: Icon(
                Icons.change_circle,
                size: 36,
              ))
        ],
      ),
      body: (isCPF)
          ? WebViewWidget(controller: viewController)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      validator: (cnpj) => AppValidator().cnpjValidator(cnpj),
                      controller: controller,
                      decoration: InputDecoration(
                          label: Text('Digite um CNPJ'),
                          contentPadding: EdgeInsets.only(left: 10),
                          border: OutlineInputBorder(),
                          hintText: 'CNPJ'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          onPressed: () => controller.text = '',
                          child: Text('Limpar'),
                        ),
                        OutlinedButton(
                          onPressed: () async {
                            setState(() {
                              isFull = true;
                            });
                            await myController.getCNPJ(controller.text);
                            setState(() {});
                          },
                          child: Text('Consultar CNPJ'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    (isFull)
                        ? SizedBox(
                            height: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                    child: Text(
                                        'Situação: ${myController.cnpjData.situacao}')),
                                SizedBox(
                                  height: 20,
                                ),
                                Flexible(
                                  child: Text(
                                      'Razão Social: ${myController.cnpjData.nome}'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Flexible(
                                    child: Text(
                                        'Nome Fantasia: ${myController.cnpjData.fantasia}')),
                                SizedBox(
                                  height: 20,
                                ),
                                Flexible(
                                  child: Text(
                                      'Endereço: ${myController.cnpjData.logradouro}, ${myController.cnpjData.bairro}, ${myController.cnpjData.municipio}'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
    );
  }
}
