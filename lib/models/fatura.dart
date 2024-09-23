import 'package:trigg_app/models/lancamento_fatura.dart';
import 'package:trigg_app/models/simple_type.dart';

class Fatura {
    Fatura({
        required this.saldoAnterior,
        required this.pagamentoMinimo,
        required this.saldoFatura,
        required this.totalCreditos,
        required this.totalDebitos,
        required this.pagamentoFatura,
        required this.pagamentoRemanescente,
        required this.lancamentos,
        required this.faturasFuturas,
        required this.status,
        required this.dataVencimento,
        required this.dataFechamento,
        this.linhaDigitavel,
        required this.periodo,
        this.repository,
    });

    final double saldoAnterior;
    final double pagamentoMinimo;
    final double saldoFatura;
    final double totalCreditos;
    final double totalDebitos;
    final double pagamentoFatura;
    final double pagamentoRemanescente;
    final List<LancamentoFatura> lancamentos;
    final List<dynamic> faturasFuturas;
    final SimpleType status;
    final DateTime dataVencimento;
    final DateTime dataFechamento;
    final dynamic linhaDigitavel;
    final String periodo;
    final dynamic repository;

    factory Fatura.fromJson(Map<String, dynamic> json) => Fatura(
        saldoAnterior: json["saldoAnterior"].toDouble(),
        pagamentoMinimo: json["pagamentoMinimo"].toDouble(),
        saldoFatura: json["saldoFatura"].toDouble(),
        totalCreditos: json["totalCreditos"].toDouble(),
        totalDebitos: json["totalDebitos"].toDouble(),
        pagamentoFatura: json["pagamentoFatura"].toDouble(),
        pagamentoRemanescente: json["pagamentoRemanescente"].toDouble(),
        lancamentos: List<LancamentoFatura>.from(json["lancamentos"].map((x) => LancamentoFatura.fromJson(x))),
        faturasFuturas: List<dynamic>.from(json["faturasFuturas"].map((x) => x)),
        status: SimpleType.fromJson(json["status"]),
        dataVencimento: DateTime.parse(json["dataVencimento"]),
        dataFechamento: DateTime.parse(json["dataFechamento"]),
        linhaDigitavel: json["linhaDigitavel"],
        periodo: json["periodo"],
        repository: json["repository"],
    );
}