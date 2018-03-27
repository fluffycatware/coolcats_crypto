import 'package:flutter/material.dart';

import 'data.dart';
import 'row.dart';

class StockList extends StatelessWidget {
  const StockList({ Key key, this.stocks, this.onOpen, this.onShow, this.onAction }) : super(key: key);

  final List<Stock> stocks;
  final StockRowActionCallback onOpen;
  final StockRowActionCallback onShow;
  final StockRowActionCallback onAction;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      key: const ValueKey<String>('stock-list'),
      itemExtent: StockRow.kHeight,
      itemCount: stocks.length,
      itemBuilder: (BuildContext context, int index) {
        return new StockRow(
          stock: stocks[index],
          onPressed: onOpen,
          onDoubleTap: onShow,
          onLongPressed: onAction
        );
      },
    );
  }
}
