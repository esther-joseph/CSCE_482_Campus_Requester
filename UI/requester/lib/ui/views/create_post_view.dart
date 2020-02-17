import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:requester/ui/shared/ui_helpers.dart';
import 'package:requester/ui/widgets/input_field.dart';
import 'package:requester/viewmodels/create_post_view.model.dart';

class CreatePostView extends StatelessWidget {
  final titleController = TextEditingController();
  final descriptionControlloer = TextEditingController();

  CreatePostView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CreatePostViewModel>.withConsumer(
      viewModel: CreatePostViewModel(),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: !model.busy
              ? Icon(Icons.add)
              : CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
          onPressed: () {
            if (!model.busy) {
              model.addPost(
                  title: titleController.text,
                  description: descriptionControlloer.text);
            }
          },
          backgroundColor:
              !model.busy ? Theme.of(context).primaryColor : Colors.grey[600],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              verticalSpace(40),
              Text(
                'Create Post',
                style: TextStyle(fontSize: 26),
              ),
              verticalSpaceMedium,
              InputField(
                placeholder: 'Title',
                controller: titleController,
              ),
              InputField(
                placeholder: 'Description',
                controller: descriptionControlloer,
              ),
              verticalSpaceMedium,
              Text('Post Image'),
              verticalSpaceSmall,
              Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Text(
                  'Tap to add post image',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
