import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:requester/ui/shared/ui_helpers.dart';
import 'package:requester/ui/widgets/base_appbar.dart';
import 'package:requester/ui/widgets/input_field.dart';
import 'package:requester/viewmodels/create_post_view_model.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:requester/viewmodels/place_view_model.dart';

class CreatePostView extends StatefulWidget {
  final PlaceViewModel place;
  
  CreatePostView({Key key, @required this.place}) : super(key: key);
  
  @override
  _CreatePostViewState createState() => _CreatePostViewState(place);
}

class _CreatePostViewState extends State<CreatePostView> {
  PlaceViewModel place;
  _CreatePostViewState(this.place);

  final itemController = TextEditingController();
  final serviceFeeController = TextEditingController();
  final subTotalFeeController = TextEditingController();

  final serviceFeeControlloer = TextEditingController();

  String _time = "Not set";

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CreatePostViewModel>.withConsumer(
      viewModel: CreatePostViewModel(),
      builder: (context, model, child) => Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   child: !model.busy
        //       ? Icon(Icons.add)
        //       : CircularProgressIndicator(
        //           valueColor: AlwaysStoppedAnimation(Colors.white),
        //         ),
        //   onPressed: () {
        //     if (!model.busy) {
        //       model.addPost(
        //           item: itemController.text,
        //           serviceFee: serviceFeeControlloer.text);
        //     }
        //   },
        //   backgroundColor:
        //       !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
        // ),
        appBar: BaseAppbar.getAppBar('Create Post'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              verticalSpaceMedium,
              TextField(
                decoration: InputDecoration(
                  //TODO: get location name from place object
                  labelText: place.name,
                ),
                enabled: false,
              ),
              InputField(
                placeholder: 'Item',
                controller: itemController,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      minTime: DateTime.now(),
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                    _time =
                        'Day:${time.month}.${time.day} Time: ${time.hour}:${time.minute}';
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_time",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              verticalSpace(20),
              
              InputField(
                  placeholder: 'Service Fee',
                  controller: serviceFeeController,
                  textInputType: TextInputType.number),
              InputField(
                  placeholder: 'SubTotal',
                  controller: subTotalFeeController,
                  textInputType: TextInputType.number),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  onPressed: () {
                    if (!model.busy) {
                      model.addPost(
                          item: itemController.text,
                          serviceFee: serviceFeeControlloer.text);
                    }
                  },
                  child: const Text('Create Post!',
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