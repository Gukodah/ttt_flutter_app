class ConfiguracaoCartao {
    ConfiguracaoCartao({
        required this.desbloqueado,
        required this.compraInternacionalDesbloqueado,
        required this.saqueDesbloqueado,
        required this.limiteAtual,
        this.limiteAtualRsa,
        required this.compraLojaOnlineDesbloqueado,
        required this.compraLojaFisicaDesbloqueado,
        required this.overlimit,
    });

    final bool desbloqueado;
    final bool compraInternacionalDesbloqueado;
    final bool saqueDesbloqueado;
    final double limiteAtual;
    final dynamic limiteAtualRsa;
    final bool compraLojaOnlineDesbloqueado;
    final bool compraLojaFisicaDesbloqueado;
    final bool overlimit;

    factory ConfiguracaoCartao.fromJson(Map<String, dynamic> json) => ConfiguracaoCartao(
        desbloqueado: json["desbloqueado"],
        compraInternacionalDesbloqueado: json["compraInternacionalDesbloqueado"],
        saqueDesbloqueado: json["saqueDesbloqueado"],
        limiteAtual: json["limiteAtual"],
        limiteAtualRsa: json["limiteAtualRsa"],
        compraLojaOnlineDesbloqueado: json["compraLojaOnlineDesbloqueado"],
        compraLojaFisicaDesbloqueado: json["compraLojaFisicaDesbloqueado"],
        overlimit: json["overlimit"],
    );
}