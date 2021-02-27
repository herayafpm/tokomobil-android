import 'package:intl/intl.dart';

abstract class ConvertUtil {
  static String formatMoney(int money) {
    var f = new NumberFormat("#,###,###", "id_ID");
    return f.format(money);
  }
}
