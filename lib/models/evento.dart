import 'dart:convert';
import 'package:trigg_app/models/simple_type.dart';

List<Evento> eventoListFromJson(String str) => List<Evento>.from(json.decode(str).map((x) => Evento.fromJson(x)));

class Evento {
    Evento({
        required this.id,
        required this.clienteId,
        required this.tipo,
        this.compraOnline,
        required this.data,
        this.periodo,
        this.parcela,
        this.valor,
        this.valorConvertido,
        this.origem,
        this.cartaoCreditoNumero,
        this.icon,
        this.categoria,
        required this.status,
        this.geoLocalizacao,
        this.contestacoes,
        this.moeda,
        required this.cancelamento,
        required this.compraConfirmada,
        required this.titulo,
        this.mensagem,
        this.cep,
        this.produtoTipo,
    });

    final String id;
    final String clienteId;
    final SimpleType tipo;
    final bool? compraOnline;
    final DateTime data;
    final String? periodo;
    final String? parcela;
    final double? valor;
    final double? valorConvertido;
    final SimpleType? origem;
    final String? cartaoCreditoNumero;
    final dynamic icon;
    final SimpleType? categoria;
    final SimpleType status;
    final dynamic geoLocalizacao;
    final dynamic contestacoes;
    final SimpleType? moeda;
    final bool cancelamento;
    final bool compraConfirmada;
    final String titulo;
    final String? mensagem;
    final String? cep;
    final SimpleType? produtoTipo;

    factory Evento.fromJson(Map<String, dynamic> json) => Evento(
        id: json["id"],
        clienteId: json["clienteId"],
        tipo: SimpleType.fromJson(json["tipo"]),
        compraOnline: json["compraOnline"] ?? null,
        data: DateTime.parse(json["data"]),
        periodo: json["periodo"] ?? null,
        parcela: json["parcela"] ?? null,
        valor: json["valor"] == null ? null : json["valor"].toDouble(),
        valorConvertido: json["valorConvertido"] == null ? null : json["valorConvertido"].toDouble(),
        origem: json["origem"] == null ? null : SimpleType.fromJson(json["origem"]),
        cartaoCreditoNumero: json["cartaoCreditoNumero"] ?? null,
        icon: json["icon"],
        categoria: json["categoria"] == null ? null : SimpleType.fromJson(json["categoria"]),
        status: SimpleType.fromJson(json["status"]),
        geoLocalizacao: json["geoLocalizacao"],
        contestacoes: json["contestacoes"],
        moeda: json["moeda"] == null ? null : SimpleType.fromJson(json["moeda"]),
        cancelamento: json["cancelamento"],
        compraConfirmada: json["compraConfirmada"],
        titulo: json["titulo"],
        mensagem: json["mensagem"] ?? null,
        cep: json["cep"] ?? null,
        produtoTipo: json["produtoTipo"] == null ? null : SimpleType.fromJson(json["produtoTipo"]),
    );
}