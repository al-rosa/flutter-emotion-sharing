import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

/// DateTime型の引数を受け取り、文字列に整形して返す関数
String formatDateTime(DateTime dateTime) {
  initializeDateFormatting('ja_JP');
  DateFormat formatter = new DateFormat('yyyy/MM/dd/ HH:mm', 'ja_JP');

  return formatter.format(dateTime);
}
