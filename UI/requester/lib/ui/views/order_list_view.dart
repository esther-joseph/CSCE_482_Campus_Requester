import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:requester/models/post.dart';
import 'package:requester/ui/shared/ui_helpers.dart';
import 'package:requester/viewmodels/order_list_view_model.dart';

class OrderListView extends StatefulWidget {
  @override
  _OrderListViewState createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<OrderListViewModel>.withConsumer(
      viewModel: OrderListViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff800000),
            title: Text('Order List'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(35),
                Row(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                      child: Image.asset('assets/images/title.png'),
                    ),
                  ],
                ),
                (model.orders != null)
                    ? Expanded(
                        child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.black,
                                ),
                            itemCount: model.orders.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  color: Colors.green,
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text("Item : " +
                                                model.orders[index].item +
                                                ", "),
                                            Text("Service Fee : " +
                                                model.orders[index].serviceFee)
                                          ],
                                        ),
                                        Text("From : " +
                                            model.orders[index].name),
                                      ])
                                    ],
                                  ));
                            }))
                    : Text('No orders')
              ],
            ),
          )),
    );
  }
}
