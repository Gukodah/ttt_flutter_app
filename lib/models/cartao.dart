import 'package:trigg_app/models/aumento_limite_concedido.dart';
import 'package:trigg_app/models/configuracao_cartao.dart';
import 'package:trigg_app/models/simple_type.dart';

class Cartao {
  Cartao({
    required this.numero,
    required this.cpf,
    required this.nomeImpresso,
    required this.validade,
    required this.melhorDiaCompra,
    required this.vencimentoFatura,
    required this.adicional,
    required this.configuracao,
    required this.valorUtilizado,
    required this.valorDisponivel,
    required this.limiteTotal,
    required this.status,
    required this.statusFaturaAtual,
    required this.permiteParcelamento,
    required this.valorGasto,
    required this.valorLancamentosFuturos,
    required this.statusView,
    required this.saldoFaturaAtual,
    required this.saldoFaturaAberta,
    this.periodoFaturas,
    required this.periodo,
    required this.statusCartaoVirtual,
    required this.limiteCartaoVirtual,
    required this.cor,
    required this.faturaVencida,
    this.existeCartaoBloqueado,
    required this.diasAtrasoAcumulado,
    required this.produtoTipo,
    required this.principal,
    required this.grupoUpgrade,
    required this.aumentoLimiteConcedido,
    this.modeloPlastico,
    required this.grupoAfinidade,
    required this.limiteLiberado,
    required this.diaVencimento,
    required this.qtdDiaAtraso,
  });

  final int numero;
  final String cpf;
  final String nomeImpresso;
  final String validade;
  final DateTime melhorDiaCompra;
  final DateTime vencimentoFatura;
  final bool adicional;
  final ConfiguracaoCartao configuracao;
  final double valorUtilizado;
  final double valorDisponivel;
  final double limiteTotal;
  final SimpleType status;
  final SimpleType statusFaturaAtual;
  final bool permiteParcelamento;
  final double valorGasto;
  final double valorLancamentosFuturos;
  final SimpleType statusView;
  final double saldoFaturaAtual;
  final double saldoFaturaAberta;
  final dynamic periodoFaturas;
  final String periodo;
  final SimpleType statusCartaoVirtual;
  final double limiteCartaoVirtual;
  final SimpleType cor;
  final bool faturaVencida;
  final bool? existeCartaoBloqueado;
  final int diasAtrasoAcumulado;
  final SimpleType produtoTipo;
  final bool principal;
  final int grupoUpgrade;
  final AumentoLimiteConcedido aumentoLimiteConcedido;
  final dynamic modeloPlastico;
  final SimpleType grupoAfinidade;
  final double limiteLiberado;
  final int diaVencimento;
  final int qtdDiaAtraso;

  factory Cartao.fromJson(Map<String, dynamic> json) => Cartao(
        numero: int.parse(json["numero"]),
        cpf: json["cpf"],
        nomeImpresso: json["nomeImpresso"],
        validade: json["validade"],
        melhorDiaCompra: DateTime.parse(json["melhorDiaCompra"]),
        vencimentoFatura: DateTime.parse(json["vencimentoFatura"]),
        adicional: json["adicional"],
        configuracao: ConfiguracaoCartao.fromJson(json["configuracao"]),
        valorUtilizado: json["valorUtilizado"].toDouble(),
        valorDisponivel: json["valorDisponivel"].toDouble(),
        limiteTotal: json["limiteTotal"],
        status: SimpleType.fromJson(json["status"]),
        statusFaturaAtual: SimpleType.fromJson(json["statusFaturaAtual"]),
        permiteParcelamento: json["permiteParcelamento"],
        valorGasto: json["valorGasto"].toDouble(),
        valorLancamentosFuturos: json["valorLancamentosFuturos"],
        statusView: SimpleType.fromJson(json["statusView"]),
        saldoFaturaAtual: json["saldoFaturaAtual"].toDouble(),
        saldoFaturaAberta: json["saldoFaturaAberta"].toDouble(),
        periodoFaturas: json["periodoFaturas"],
        periodo: json["periodo"],
        statusCartaoVirtual: SimpleType.fromJson(json["statusCartaoVirtual"]),
        limiteCartaoVirtual: json["limiteCartaoVirtual"],
        cor: SimpleType.fromJson(json["cor"]),
        faturaVencida: json["faturaVencida"],
        existeCartaoBloqueado: json["existeCartaoBloqueado"],
        diasAtrasoAcumulado: json["diasAtrasoAcumulado"],
        produtoTipo: SimpleType.fromJson(json["produtoTipo"]),
        principal: json["principal"],
        grupoUpgrade: json["grupoUpgrade"],
        aumentoLimiteConcedido:
            AumentoLimiteConcedido.fromJson(json["aumentoLimiteConcedido"]),
        modeloPlastico: json["modeloPlastico"],
        grupoAfinidade: SimpleType.fromJson(json["grupoAfinidade"]),
        limiteLiberado: json["limiteLiberado"].toDouble(),
        diaVencimento: json["diaVencimento"],
        qtdDiaAtraso: json["qtdDiaAtraso"],
      );
}
