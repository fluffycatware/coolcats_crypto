import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:coolcats_crypto/main.dart' as stocks;
import 'package:coolcats_crypto/crypto/data.dart' as stock_data;

void main() {
  stock_data.StockData.actuallyFetchData = false;

  testWidgets('Search', (WidgetTester tester) async {
    stocks.main(); // builds the app and schedules a frame but doesn't trigger one
    await tester.pump(); // see https://github.com/flutter/flutter/issues/1865
    await tester.pump(); // triggers a frame

    expect(find.text('ETH'), findsNothing);
    expect(find.text('BTC'), findsNothing);

    final stocks.StocksAppState app = tester.state<stocks.StocksAppState>(find.byType(stocks.StocksApp));
    const JsonDecoder decoder = const JsonDecoder();
    app.stocks.add(decoder.convert("[{\"id\":\"apple\",\"name\":\"Apple\",\"symbol\":\"ETH\",\"rank\":\"\",\"price_usd\":\"\",\"price_btc\":\"\",\"24h_volume_usd\":\"\",\"market_cap_usd\":\"\",\"available_supply\":\"\",\"total_supply\":\"\",\"max_supply\":\"\",\"percent_change_1h\":\"\",\"percent_change_24h\":\"\",\"percent_change_7d\":\"\",\"last_updated\":\"\"},{\"id\":\"banana\",\"name\":\"Banana\",\"symbol\":\"BTC\",\"rank\":\"\",\"price_usd\":\"\",\"price_btc\":\"\",\"24h_volume_usd\":\"\",\"market_cap_usd\":\"\",\"available_supply\":\"\",\"total_supply\":\"\",\"max_supply\":\"\",\"percent_change_1h\":\"\",\"percent_change_24h\":\"\",\"percent_change_7d\":\"\",\"last_updated\":\"\"}]"));
    await tester.pump();

    expect(find.text('ETH'), findsOneWidget);
    expect(find.text('BTC'), findsOneWidget);

    await tester.tap(find.byTooltip('Search'));
    // We skip a minute at a time so that each phase of the animation
    // is done in two frames, the start frame and the end frame.
    // There are two phases currently, so that results in three frames.
    expect(await tester.pumpAndSettle(const Duration(minutes: 1)), 3);

    expect(find.text('ETH'), findsOneWidget);
    expect(find.text('BTC'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'B');
    await tester.pump();

    expect(find.text('ETH'), findsNothing);
    expect(find.text('BTC'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'X');
    await tester.pump();

    expect(find.text('ETH'), findsNothing);
    expect(find.text('BTC'), findsNothing);
  });
}
