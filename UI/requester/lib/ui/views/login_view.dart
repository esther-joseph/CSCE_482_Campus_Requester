import 'package:requester/ui/shared/ui_helpers.dart';
import 'package:requester/ui/widgets/base_appbar.dart';
import 'package:requester/ui/widgets/busy_button.dart';
import 'package:requester/ui/widgets/input_field.dart';
import 'package:requester/ui/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:requester/viewmodels/login_view_model.dart';

class LoginView extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>.withConsumer(
      viewModel: LoginViewModel(),
      builder: (context, model, child) => Scaffold(
          appBar: BaseAppbar.getAppBar('Log In'),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    height: 150,
                    //TODO Have to add Icon on the images folder
                    child: Image.asset('assets/images/tamu_logo.png')),
                InputField(
                  placeholder: 'Username',
                  controller: usernameController,
                ),
                verticalSpaceSmall,
                InputField(
                  placeholder: 'Password',
                  password: true,
                  controller: passwordController,
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BusyButton(
                      title: 'Login',
                      busy: model.busy,
                      onPressed: () {
                        // TODO: Perform login here

                        model.signIn(
                            username: usernameController.text,
                            password: passwordController.text);
                      },
                    )
                  ],
                ),
                verticalSpaceMedium,
                TextLink(
                  'Create an Account if you\'re new.',
                  onPressed: () {
                    model.navigateToSignUp();
                  },
                )
              ],
            ),
          )),
    );
  }
}
