abstract class EmailValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) return "E-mail é obrigatório";
    if (!value.contains(RegExp(r"^.+\@\w+\.\w+"))) {
      return "Digite um e-mail válido";
    }
    return null;
  }
}
