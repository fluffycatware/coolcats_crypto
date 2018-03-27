// Data is sourced from https://api.coinmarketcap.com/v1/ticker/?limit=100
/*
{
  "id": "bitcoin",
  "name": "Bitcoin",
  "symbol": "BTC",
  "rank": "1",
  "price_usd": "7995.53",
  "price_btc": "1.0",
  "24h_volume_usd": "5839080000.0",
  "market_cap_usd": "135463163642",
  "available_supply": "16942362.0",
  "total_supply": "16942362.0",
  "max_supply": "21000000.0",
  "percent_change_1h": "0.24",
  "percent_change_24h": "-1.9",
  "percent_change_7d": "-7.24",
  "last_updated": "1522157968"
},
*/

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Stock {
  String symbol;
  String name;
  double lastSale;
  String marketCap;
  double percentChange;

  Stock(this.symbol, this.name, this.lastSale, this.marketCap, this.percentChange);

  Stock.fromFields(Map fields) {
    lastSale = 0.0;
    try {
      lastSale = double.parse(fields["price_usd"]);
    } catch (_) {}
    symbol = fields["symbol"];
    name = fields["name"];
    marketCap = fields["market_cap_usd"];
    percentChange = double.parse(fields["percent_change_24h"]);
  }
}

class StockData extends ChangeNotifier {
  StockData() {
    if (actuallyFetchData) {
      _httpClient = createHttpClient();
      _fetchData('https://api.coinmarketcap.com/v1/ticker/?limit=100.json');
    }
  }

  final List<String> _symbols = <String>[];
  final Map<String, Stock> _stocks = <String, Stock>{};

  Iterable<String> get allSymbols => _symbols;

  Stock operator [](String symbol) => _stocks[symbol];

  bool get loading => _httpClient != null;

  void add(List<Map> data) {
    for(Map field in data) {
      final Stock stock = new Stock.fromFields(field);
      _symbols.add(stock.symbol);
      _stocks[stock.symbol] = stock;
    }
    _symbols.sort();
    notifyListeners();
  }

  http.Client _httpClient;

  static bool actuallyFetchData = true;

  void _fetchData(String url) {
    _httpClient.get(url).then<Null>((http.Response response) {
      final String json = response.body;
      if (json == null) {
        _end();
        return;
      }
      const JsonDecoder decoder = const JsonDecoder();
      List<Map> parsedMap = decoder.convert(json);
      add(parsedMap);
      _end();
    });
  }

  void _end() {
    _httpClient?.close();
    _httpClient = null;
  }
}
