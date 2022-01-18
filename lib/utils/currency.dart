import 'package:intl/intl.dart';

//for simplified code in curenncy
class CurrencyUtils {
 static String currencyIDR(int value) {
   return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(value);
 }
 static String currencyIDRwoSymbol(int value){
   return NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format(value);
 }
}