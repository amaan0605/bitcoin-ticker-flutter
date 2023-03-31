import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'ui_elements.dart';
import 'coin_data.dart';

const url = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '1DBA5417-46D0-4A08-A4C7-2D5E8E308997';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String selectedCyptoCoin = 'BTC';
  String requestedURL;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> currencyList = [];
    for (String currency in currenciesList) {
      currencyList.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 25.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currencyList[selectedIndex].toString();
        getData();
      },
      children: currencyList,
    );
  }

  String cyptoCoinData = '?';
  void getData() async {
    try {
      requestedURL = '$url/$selectedCyptoCoin/$selectedCurrency?apikey=$apiKey';
      CoinData coinData =
          CoinData(selectedCurrency, selectedCyptoCoin, requestedURL);
      var data = await coinData.getData();
      setState(() {
        cyptoCoinData = data.toStringAsFixed(1);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: ReusableCard(
              showCypto: 'BTC',
              cyptoCoin: cyptoCoinData,
              selectedCurrency: selectedCurrency,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
            child: ReusableCard(
              showCypto: 'ETH',
              cyptoCoin: cyptoCoinData,
              selectedCurrency: selectedCurrency,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
            child: ReusableCard(
              showCypto: 'LTC',
              cyptoCoin: cyptoCoinData,
              selectedCurrency: selectedCurrency,
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
