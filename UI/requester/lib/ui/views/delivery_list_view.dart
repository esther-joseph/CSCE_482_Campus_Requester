import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:requester/models/post.dart';
import 'package:requester/ui/shared/ui_helpers.dart';
import 'package:requester/viewmodels/delivery_list_view_model.dart';
import 'package:requester/viewmodels/order_list_view_model.dart';

class DeliveryListView extends StatefulWidget {
  @override
  _DeliveryListViewState createState() => _DeliveryListViewState();
}

class _DeliveryListViewState extends State<DeliveryListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<DeliveryListViewModel>.withConsumer(
      viewModel: DeliveryListViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff800000),
            title: Text('Delivery List'),
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
                (model.deliveries != null)
                    ? Expanded(
                        child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.black,
                                ),
                            itemCount: model.deliveries.length,
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
                                                model.deliveries[index].item +
                                                ", "),
                                            Text("Service Fee : " +
                                                model.deliveries[index]
                                                    .serviceFee)
                                          ],
                                        ),
                                        Text("From : " +
                                            model.deliveries[index].name),
                                      ])
                                    ],
                                  ));
                            }))
                    : Text('No deliveries')
              ],
            ),
          )),
    );
  }
}
