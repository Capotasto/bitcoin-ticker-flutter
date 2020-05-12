import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkRepository {
  static const String BASE_URL = 'https://rest.coinapi.io/v1/exchangerate';
  static const String API_KEY = '65D31619-7A17-448C-B119-373AB055C208';

  final String assetIdBase;
  final String assetIdQuote;

  NetworkRepository(this.assetIdBase, this.assetIdQuote);

  Future<dynamic> getCoinData() async {
    String url = "$BASE_URL/$assetIdBase/$assetIdQuote";
    print("Get request to: $url");
    http.Response response =
        await http.get(url, headers: {"X-CoinAPI-Key": API_KEY});
    print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
