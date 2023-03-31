import 'package:http/http.dart' as http;
import 'dart:convert';
import 'price_screen.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  CoinData(this.selectedCurrency, this.cyptoCoin, this.requestedURL);
  String selectedCurrency;
  String cyptoCoin;
  String requestedURL;
  Future getData() async {
    http.Response response = await http.get(requestedURL);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data)['rate'];
    } else {
      print(response.statusCode);
      throw 'Problem with the get Request';
    }
  }
}
