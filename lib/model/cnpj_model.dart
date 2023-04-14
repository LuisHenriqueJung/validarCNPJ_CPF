// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CNPJ {
  String situacao;
  String nome;
  String fantasia;
  String municipio;
  String bairro;
  String logradouro;
  CNPJ({
    required this.situacao,
    required this.nome,
    required this.fantasia,
    required this.municipio,
    required this.bairro,
    required this.logradouro,
  });

  CNPJ copyWith({
    String? situacao,
    String? nome,
    String? fantasia,
    String? municipio,
    String? bairro,
    String? logradouro,
  }) {
    return CNPJ(
      situacao: situacao ?? this.situacao,
      nome: nome ?? this.nome,
      fantasia: fantasia ?? this.fantasia,
      municipio: municipio ?? this.municipio,
      bairro: bairro ?? this.bairro,
      logradouro: logradouro ?? this.logradouro,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'situacao': situacao,
      'nome': nome,
      'fantasia': fantasia,
      'municipio': municipio,
      'bairro': bairro,
      'logradouro': logradouro,
    };
  }

  factory CNPJ.fromMap(Map<String, dynamic> map) {
    return CNPJ(
      situacao: map['situacao'] as String,
      nome: map['nome'] as String,
      fantasia: map['fantasia'] as String,
      municipio: map['municipio'] as String,
      bairro: map['bairro'] as String,
      logradouro: map['logradouro'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CNPJ.fromJson(String source) =>
      CNPJ.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CNPJ(situacao: $situacao, nome: $nome, fantasia: $fantasia, municipio: $municipio, bairro: $bairro, logradouro: $logradouro)';
  }

  @override
  bool operator ==(covariant CNPJ other) {
    if (identical(this, other)) return true;

    return other.situacao == situacao &&
        other.nome == nome &&
        other.fantasia == fantasia &&
        other.municipio == municipio &&
        other.bairro == bairro &&
        other.logradouro == logradouro;
  }

  @override
  int get hashCode {
    return situacao.hashCode ^
        nome.hashCode ^
        fantasia.hashCode ^
        municipio.hashCode ^
        bairro.hashCode ^
        logradouro.hashCode;
  }
}
