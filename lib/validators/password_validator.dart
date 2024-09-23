abstract class PasswordValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) return "Senha é obrigatória";
    if (value.length < 6) return "A senha deve ter no mínimo 6 caracteres";
    return null;
  }
}
