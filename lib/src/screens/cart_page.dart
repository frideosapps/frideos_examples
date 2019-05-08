import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';

import '../blocs/bloc.dart';
import '../blocs/cart_bloc.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartBloc bloc = BlocProvider.of(context);

    final width = MediaQuery.of(context).size.width - 16.0;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Catalog'),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 8.0, right: 8.0),
              child: ValueBuilder<List<CatalogItem>>(
                  streamed: bloc.catalog,
                  builder: (context, snapshotItem) {
                    final widgets = List<Widget>();

                    widgets
                      ..add(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                                width: (width / 6) * 0.5,
                                child: const Text('ID')),
                            SizedBox(
                                width: (width / 6) * 2,
                                child: const Text('Product')),
                            SizedBox(
                                width: width / 6, child: const Text('Price')),
                            SizedBox(
                                width: (width / 6) * 2,
                                child: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Text('Quantity'),
                                )),
                            SizedBox(width: (width / 6) * 0.5),
                          ],
                        ),
                      )
                      ..addAll(snapshotItem.data
                          .map((p) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    SizedBox(
                                      width: (width / 6) * 0.5,
                                      child: Text(
                                        p.id.toString(),
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.grey),
                                      ),
                                    ),
                                    SizedBox(
                                      width: (width / 6) * 2,
                                      child: Text(
                                        products[p.id].name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blue),
                                      ),
                                    ),
                                    SizedBox(
                                        width: width / 6,
                                        child: Text(
                                          products[p.id]
                                              .price
                                              .toStringAsFixed(2),
                                        )),
                                    SizedBox(
                                      width: (width / 6) * 2,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0),
                                        child: StreamBuilder<int>(
                                            stream: p.quantity.outStream,
                                            builder:
                                                (context, snapshotQuantity) {
                                              return TextField(
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Insert the quantity.',
                                                    hintStyle: const TextStyle(
                                                        fontSize: 8),
                                                    errorText:
                                                        snapshotQuantity.error,
                                                    errorStyle: const TextStyle(
                                                        fontSize: 8)),
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: (value) =>
                                                    bloc.changeQuantity(
                                                        p.id, value),
                                              );
                                            }),
                                      ),
                                    ),
                                    SizedBox(
                                      width: (width / 6) * 0.5,
                                      height: 30,
                                      child: ValueBuilder<bool>(
                                          //returnNull: true,
                                          streamed: p.added,
                                          builder: (context, snapshotAdded) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6.0),
                                              child: !snapshotAdded.hasData
                                                  ? Container()
                                                  : RaisedButton(
                                                      padding: EdgeInsets.zero,
                                                      color: Colors.green,
                                                      child: const Text(
                                                        '+',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onPressed: !snapshotAdded
                                                                  .data &&
                                                              p.quantity
                                                                      .value !=
                                                                  null
                                                          ? () =>
                                                              bloc.addItem(p.id)
                                                          : null,
                                                    ),
                                            );
                                          }),
                                    ),
                                  ]))
                          .toList());

                    return Column(children: widgets);
                  }),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ValueBuilder<List<int>>(
                  streamed: bloc.cart,
                  builder: (context, snapshot) {
                    final widgets = List<Widget>();

                    widgets.add(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              width: (width / 6) * 0.5,
                              child: const Text('ID')),
                          SizedBox(
                              width: (width / 6) * 1.5,
                              child: const Text('Product')),
                          SizedBox(
                              width: (width / 6) * 1.5,
                              child: const Text('Quantity')),
                          SizedBox(
                              width: (width / 6) * 2,
                              child: Text('Total price')),
                          SizedBox(
                            width: (width / 6) * 0.5,
                          ),
                        ],
                      ),
                    );

                    if (snapshot.data.isNotEmpty) {
                      widgets.addAll(snapshot.data.map((id) {
                        final item = bloc.getItem(id);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: (width / 6) * 0.5,
                              child: Text(id.toString(),
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.grey)),
                            ),
                            SizedBox(
                                width: (width / 6) * 1.5,
                                child: Text(products[id].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue))),
                            SizedBox(
                              width: (width / 6),
                              child: Text(item.quantity.value.toString()),
                            ),
                            SizedBox(
                                width: (width / 6) * 1.5,
                                child: Text(
                                    item.totalPrice.value.toStringAsFixed(2))),
                            SizedBox(
                              width: (width / 6) * 0.5,
                              height: 30,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                child: RaisedButton(
                                  padding: EdgeInsets.zero,
                                  color: Colors.red,
                                  child: const Text(
                                    'x',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () => bloc.removeItem(item.id),
                                ),
                              ),
                            )
                          ],
                        );
                      }).toList());
                    }

                    return snapshot.data.isEmpty
                        ? Container()
                        : Column(children: widgets);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
