import 'package:http/http.dart' as http;
import 'package:moeayexchange/models/convert_currency_model.dart';
import 'dart:convert' as convert;

import 'package:moeayexchange/models/symbols_model.dart';

class BaseNetwork {
  //! گرفتن ارز ها
  static Future<SymbolsModel> getSymbols() async {
    Uri url = Uri.parse('https://api.apilayer.com/exchangerates_data/symbols');

    Map<String, String> headers2 = {
      'apikey': 'lJDwS8SWoKEtvx6WJWT9aiFnszJIR0Fi'
    };
    var response = await http.get(url, headers: headers2);
    return SymbolsModel.fromJson(convert.jsonDecode(response.body));
  }

  //! تبدیل ارز
  static Future<ConvertCurrencyModel> convertCurrency(
      {required String from,
      required String to,
      required String amount}) async {
    Uri url = Uri.parse(
        'https://api.apilayer.com/exchangerates_data/convert?to=$to&from=$from&amount=$amount');

    Map<String, String> headers2 = {
      'apikey': 'lJDwS8SWoKEtvx6WJWT9aiFnszJIR0Fi'
    };

    var response = await http.get(url, headers: headers2);
    return ConvertCurrencyModel.fromJson(convert.jsonDecode(response.body));
  }
}
