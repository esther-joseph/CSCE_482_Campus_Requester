import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:requester/ui/shared/ui_helpers.dart';
import 'package:requester/ui/widgets/base_appbar.dart';
import 'package:requester/ui/widgets/busy_overlay.dart';
import 'package:requester/ui/widgets/input_field.dart';
import 'package:requester/ui/widgets/place_list.dart';
import 'package:requester/utils/url_helper.dart';
import 'package:requester/viewmodels/create_post_view_model.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:requester/viewmodels/place_view_model.dart';

class CreatePostView extends StatefulWidget {
  //final PlaceViewModel place;

  CreatePostView({Key key}) : super(key: key);

  @override
  _CreatePostViewState createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  // _CreatePostViewState(this.place);

  final itemController = TextEditingController();
  final priceController = TextEditingController();

  final serviceFeeController = TextEditingController();

  String _time = "Not set";

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CreatePostViewModel>.withConsumer(
      viewModel: CreatePostViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: BaseAppbar.getAppBar('Create Post'),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: BusyOverlay(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpaceMedium,
                    TextField(
                      onSubmitted: (value) {
                        model.fetchPlacesByKeywordAndPosition(value);
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => ListView.builder(
                                  itemCount: model.places.length,
                                  itemBuilder: (context, index) {
                                    final place = model.places[index];
                                    return ListTile(
                                        onTap: () {
                                          //go to create post
                                          model.onSelected(place);
                                          Navigator.pop(context);
                                        },
                                        leading: Container(
                                            width: 100,
                                            height: 100,
                                            child: Image.network(
                                                UrlHelper.urlForReferenceImage(
                                                    place.photoURL),
                                                fit: BoxFit.cover)),
                                        title: Text(place.name));
                                  },
                                ));
                      },
                      decoration: InputDecoration(
                          labelText: "What do you want?",
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    (model.selectedPosition != null)
                        ? TextField(
                            decoration: InputDecoration(
                              labelText: model.selectedPosition.name,
                            ),
                            enabled: false,
                          )
                        : TextField(
                            decoration: InputDecoration(
                              labelText: "",
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
                            //currentTime: DateTime.now(),
                            showTitleActions: true,
                            theme: DatePickerTheme(
                              containerHeight: 210.0,
                            ),
                            onConfirm: (time) {
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
                    verticalSpace(10),
                    InputField(
                        placeholder: 'Service Fee',
                        controller: serviceFeeController,
                        textInputType: TextInputType.number),
                    InputField(
                        placeholder: 'price',
                        controller: priceController,
                        textInputType: TextInputType.number),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                        onPressed: () {
                          model.addPost(
                              item: itemController.text,
                              serviceFee: serviceFeeController.text,
                              price: priceController.text,
                              place: model.selectedPosition,
                              deliveryTime: _time);
                        },
                        child: const Text('Create Post!',
                            style: TextStyle(fontSize: 20)),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        elevation: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
