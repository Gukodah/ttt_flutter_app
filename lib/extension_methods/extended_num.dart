import 'package:intl/intl.dart';

final nFormat = NumberFormat.currency(locale: "pt_BR", symbol: "R\$");

extension ExtendedNum on num {
  toCurrencyString() {
    return nFormat.format(this);
  }
}