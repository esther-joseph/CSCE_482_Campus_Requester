import 'package:intl/intl.dart';

import 'package:requester/models/post.dart';
import 'package:requester/ui/shared/ui_helpers.dart';
import 'package:requester/ui/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:requester/viewmodels/post_list_view_model.dart';

class ItemModel {
  bool isExpanded;
  Post post;

  ItemModel({this.isExpanded: false, this.post});
}

class PostListView extends StatefulWidget {
  @override
  _PostListViewState createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<PostListViewModel>.withConsumer(
        viewModel: PostListViewModel(),
        //onModelReady: (model) => model.fetchPosts(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child:
                    !model.busy ? Icon(Icons.add) : CircularProgressIndicator(),
                onPressed: model.navigateToCreateView,
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
                    Expanded(
                        /*
                          child: model.posts != null
                            ? ListView.builder(
                                itemCount: model.posts.length,
                                itemBuilder: (context, index) =>
                                    PostItem(post: model.posts[index]),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      Theme.of(context).primaryColor),
                                ),
                              )
                            */
                        child: ListView.builder(
                            itemCount: prepareData.length,
                            itemBuilder: (context, index) {
                              return ExpansionPanelList(
                                animationDuration: Duration(seconds: 1),
                                children: [
                                  ExpansionPanel(
                                    body: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Item: ${prepareData[index].post.item}',
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            'Service Fee: ${prepareData[index].post.serviceFee}',
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    headerBuilder: (context, isExpanded) {
                                      return Container(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                  prepareData[index].post.item),
                                              Text(DateFormat(
                                                      'kk:mm:ss \n EEE d MMM')
                                                  .format(prepareData[index]
                                                      .post
                                                      .deliverBy)),
                                              Text(prepareData[index]
                                                  .post
                                                  .serviceFee),
                                            ],
                                          ));
                                    },
                                    isExpanded: prepareData[index].isExpanded,
                                  )
                                ],
                                expansionCallback: (item, status) {
                                  setState(() {
                                    prepareData[index].isExpanded =
                                        !prepareData[index].isExpanded;
                                  });
                                },
                              );
                            }))
                  ],
                ),
              ),
            ));
  }

  List<ItemModel> prepareData = <ItemModel>[
    ItemModel(
        post: Post(
            item: 'bigMac', serviceFee: '\$30', deliverBy: DateTime.now())),
    ItemModel(
        post: Post(
            item: 'Subway', serviceFee: '\$30', deliverBy: DateTime.now())),
    ItemModel(
        post:
            Post(item: 'Panda', serviceFee: '\$30', deliverBy: DateTime.now())),
    ItemModel(
        post: Post(
            item: 'Macdonald', serviceFee: '\$30', deliverBy: DateTime.now())),
  ];
}
