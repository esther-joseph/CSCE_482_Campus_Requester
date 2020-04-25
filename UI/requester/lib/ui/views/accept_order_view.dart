import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:requester/ui/shared/ui_helpers.dart';
import 'package:requester/ui/widgets/base_appbar.dart';
import 'package:requester/ui/widgets/input_field.dart';
import 'package:requester/viewmodels/accept_order_view_model.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:requester/viewmodels/place_view_model.dart';

class AcceptOrderView extends StatefulWidget {
  final PlaceViewModel place;
  
  AcceptOrderView({Key key, @required this.place}) : super(key: key);
  
  @override
  _AcceptOrderViewState createState() => _AcceptOrderViewState(place);
}

class _AcceptOrderViewState extends State<AcceptOrderView> {
  PlaceViewModel place;
  _AcceptOrderViewState(this.place);

  final itemController = TextEditingController();
  final serviceFeeController = TextEditingController();
  final subTotalFeeController = TextEditingController();

  final serviceFeeControlloer = TextEditingController();

  String _time = "Not set";

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<AcceptOrderViewModel>.withConsumer(
      viewModel: AcceptOrderViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: BaseAppbar.getAppBar('Accept Order'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              verticalSpaceMedium,
              TextField(
                decoration: InputDecoration(
                  labelText: place.name,
                ),
                enabled: false,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "items",
                ),
                enabled: false,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Delivery Time",
                ),
                enabled: false,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  onPressed: () {
                    if (!model.busy) {
                      //TODO: change addPost to AcceptOrder once it is changed in view model
                      model.addPost(
                          item: itemController.text,
                          serviceFee: serviceFeeControlloer.text,
                          place: place);
                    }
                  },
                  child: const Text('Accept',
                      style: TextStyle(fontSize: 20)),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  elevation: 5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}