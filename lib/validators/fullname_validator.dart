abstract class FullNameValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) return "O Nome é obrigatório";
    if (!value.contains(RegExp(r"^[a-zA-Z]+\s[a-zA-Z]+"))) {
      return "Digite seu nome e sobrenome";
    }
    return null;
  }
}
