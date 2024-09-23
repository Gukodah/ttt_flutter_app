import 'package:intl/intl.dart';

abstract class DataNascimentoValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) return "A data de nascimento é obrigatória";
    if (value.length < 10) return "A data fornecida é invalida";

    DateTime currentDate = DateTime.now();

    DateTime eighteenYearsFromToday =
        currentDate.subtract(Duration(days: 6570));

    var userInputedDateSplited = value.split('/');

    DateTime userInputedDate = DateTime(
      int.parse(userInputedDateSplited[2]),
      int.parse(userInputedDateSplited[1]),
      int.parse(userInputedDateSplited[0]),
    );
    if (!userInputedDate.isBefore(eighteenYearsFromToday)) {
      return "Desculpe, você precisa ter pelo menos 18 anos";
    }
    return null;
  }
}
