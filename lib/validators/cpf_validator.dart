abstract class CpfValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) return "CPF é obrigatório";
    value = value.replaceAll(RegExp(r"[^0-9]"), "");
    if (value.length != 11) return "Digite um CPF válido";
    return null;
  }
}
