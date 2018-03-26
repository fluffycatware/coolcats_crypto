// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Snapshot from http://www.nasdaq.com/screening/company-list.aspx
// Fetched 2/23/2014.
// "Symbol","Name","LastSale","MarketCap","IPOyear","Sector","industry","Summary Quote",
// Data in stock_data.json

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

  Stock.fromFields(List<String> fields) {
    // FIXME: This class should only have static data, not lastSale, etc.
    // "Symbol","Name","LastSale","MarketCap","IPOyear","Sector","industry","Summary Quote",
    lastSale = 0.0;
    try {
      lastSale = double.parse(fields[4]);
    } catch (_) {}
    symbol = fields[2];
    name = fields[1];
    marketCap = fields[7];
    percentChange = double.parse(fields[12]);
  }
}

class StockData extends ChangeNotifier {
  StockData() {
    if (actuallyFetchData) {
      _httpClient = createHttpClient();
      _fetchNextChunk();
    }
  }

  final List<String> _symbols = <String>[];
  final Map<String, Stock> _stocks = <String, Stock>{};

  Iterable<String> get allSymbols => _symbols;

  Stock operator [](String symbol) => _stocks[symbol];

  bool get loading => _httpClient != null;

  void add(List<List<String>> data) {
    for (List<String> fields in data) {
      final Stock stock = new Stock.fromFields(fields);
      _symbols.add(stock.symbol);
      _stocks[stock.symbol] = stock;
    }
    _symbols.sort();
    notifyListeners();
  }

  http.Client _httpClient;

  static bool actuallyFetchData = true;

  void _fetchNextChunk() {
    _httpClient.get('http://localhost:8000/crypto.json').then<Null>((http.Response response) {
      final String json = response.body;
      if (json == null) {
        _end();
        return;
      }
      const JsonDecoder decoder = const JsonDecoder();
      add(decoder.convert(json));
      _end();
    });
  }

  void _end() {
    _httpClient?.close();
    _httpClient = null;
  }
}
