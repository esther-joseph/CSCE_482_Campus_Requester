import 'package:requester/constants/route_names.dart';
import 'package:requester/locator.dart';
import 'package:requester/services/flutter_store_service.dart';
import 'package:requester/services/navigation_service.dart';
import 'package:requester/viewmodels/base_model.dart';

import '../constants/route_names.dart';

class SplashViewModel extends BaseModel {
  final _flutterStoreService = locator<FlutterStoreService>();

  final _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _flutterStoreService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(LoginViewRoute);
    } else {
      _navigationService.navigateTo(LoginViewRoute);
    }
  }
}
