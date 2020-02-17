import 'package:requester/models/post.dart';
import 'package:requester/ui/shared/ui_helpers.dart';
import 'package:requester/ui/widgets/post_item.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:requester/viewmodels/posts_view_model.dart';

class Posts_view extends StatelessWidget {
  const Posts_view({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<PostsViewModel>.withConsumer(
        viewModel: PostsViewModel(),
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
                        child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) => PostItem(
                        post: Post(title: '$index Title'),
                      ),
                    ))
                  ],
                ),
              ),
            ));
  }
}
