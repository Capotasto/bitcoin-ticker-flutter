import 'package:bitcoin_ticker/network_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String btcPriceString = '1 BTC = ? USD';
  String ethPriceString = '1 ETH = ? USD';
  String ltcPriceString = '1 LTC = ? USD';

  DropdownButton getAndroidDropdownButton() {
    List<DropdownMenuItem<String>> result = [];

    for (String currency in currenciesList) {
      DropdownMenuItem item = DropdownMenuItem<String>(
        child: Text(currency),
        value: currency,
      );
      result.add(item);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: result,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  void getCurrencyRate(String base, String currency) async {
    var responseData = await NetworkRepository(base, currency).getCoinData();
    setState(() {
      double rate = responseData['rate'];
      String result = "1 $base = ${rate.round()} $currency";
      switch (base) {
        case 'BTC':
          btcPriceString = result;
          break;
        case 'ETH':
          ethPriceString = result;
          break;
        case 'LTC':
          ltcPriceString = result;
          break;
      }
    });
  }

  CupertinoPicker getiOSPicker() {
    List<Text> result = [];

    for (String currency in currenciesList) {
      Text item = Text(currency);
      result.add(item);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        String currency = currenciesList[selectedIndex];
        getCurrencyRate('BTC', currency);
        getCurrencyRate('ETH', currency);
        getCurrencyRate('LTC', currency);
      },
      children: result,
    );
  }

  @override
  void initState() {
    super.initState();
    String currency = currenciesList[0];
    getCurrencyRate('BTC', currency);
    getCurrencyRate('ETH', currency);
    getCurrencyRate('LTC', currency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  btcPriceString,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  ethPriceString,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  ltcPriceString,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: null,
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getiOSPicker() : getAndroidDropdownButton(),
          ),
        ],
      ),
    );
  }
}
