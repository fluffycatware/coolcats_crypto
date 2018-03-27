library coolcats_crypto;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show
  debugPaintSizeEnabled,
  debugPaintBaselinesEnabled,
  debugPaintLayerBordersEnabled,
  debugPaintPointersEnabled,
  debugRepaintRainbowEnabled;
import 'package:flutter_localizations/flutter_localizations.dart';

import 'crypto/data.dart';
import 'crypto/home.dart';
import 'crypto/settings.dart';
import 'crypto/strings.dart';
import 'crypto/symbol_viewer.dart';
import 'crypto/types.dart';

class _StocksLocalizationsDelegate extends LocalizationsDelegate<StockStrings> {
  @override
  Future<StockStrings> load(Locale locale) => StockStrings.load(locale);

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'es' || locale.languageCode == 'en';

  @override
  bool shouldReload(_StocksLocalizationsDelegate old) => false;
}

class StocksApp extends StatefulWidget {
  @override
  StocksAppState createState() => new StocksAppState();
}

class StocksAppState extends State<StocksApp> {
  StockData stocks;

  StockConfiguration _configuration = new StockConfiguration(
    stockMode: StockMode.optimistic,
    backupMode: BackupMode.enabled,
    debugShowGrid: false,
    debugShowSizes: false,
    debugShowBaselines: false,
    debugShowLayers: false,
    debugShowPointers: false,
    debugShowRainbow: false,
    showPerformanceOverlay: false,
    showSemanticsDebugger: false
  );

  @override
  void initState() {
    super.initState();
    stocks = new StockData();
  }

  void configurationUpdater(StockConfiguration value) {
    setState(() {
      _configuration = value;
    });
  }

  ThemeData get theme {
    switch (_configuration.stockMode) {
      case StockMode.optimistic:
        return new ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue
        );
      case StockMode.pessimistic:
        return new ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.redAccent
        );
    }
    assert(_configuration.stockMode != null);
    return null;
  }

  Route<Null> _getRoute(RouteSettings settings) {
    // Routes, by convention, are split on slashes, like filesystem paths.
    final List<String> path = settings.name.split('/');
    // We only support paths that start with a slash, so bail if
    // the first component is not empty:
    if (path[0] != '')
      return null;
    // If the path is "/stock:..." then show a stock page for the
    // specified stock symbol.
    if (path[1].startsWith('stock:')) {
      // We don't yet support subpages of a stock, so bail if there's
      // any more path components.
      if (path.length != 2)
        return null;
      // Extract the symbol part of "stock:..." and return a route
      // for that symbol.
      final String symbol = path[1].substring(6);
      return new MaterialPageRoute<Null>(
        settings: settings,
        builder: (BuildContext context) => new StockSymbolPage(symbol: symbol, stocks: stocks),
      );
    }
    // The other paths we support are in the routes table.
    return null;
  }

  @override
  Widget build(BuildContext context) {
    assert(() {
      debugPaintSizeEnabled = _configuration.debugShowSizes;
      debugPaintBaselinesEnabled = _configuration.debugShowBaselines;
      debugPaintLayerBordersEnabled = _configuration.debugShowLayers;
      debugPaintPointersEnabled = _configuration.debugShowPointers;
      debugRepaintRainbowEnabled = _configuration.debugShowRainbow;
      return true;
    }());
    return new MaterialApp(
      title: 'Stocks',
      theme: theme,
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        new _StocksLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        const Locale('en', 'US'),
        const Locale('es', 'ES'),
      ],
      debugShowMaterialGrid: _configuration.debugShowGrid,
      showPerformanceOverlay: _configuration.showPerformanceOverlay,
      showSemanticsDebugger: _configuration.showSemanticsDebugger,
      routes: <String, WidgetBuilder>{
         '/':         (BuildContext context) => new StockHome(stocks, _configuration, configurationUpdater),
         '/settings': (BuildContext context) => new StockSettings(_configuration, configurationUpdater)
      },
      onGenerateRoute: _getRoute,
    );
  }
}

void main() {
  runApp(new StocksApp());
}
