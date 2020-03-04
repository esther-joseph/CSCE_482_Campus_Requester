import 'package:requester/constants/route_names.dart';
import 'package:requester/locator.dart';
import 'package:requester/services/authentication_service.dart';
import 'package:requester/services/navigation_service.dart';
import 'package:requester/viewmodels/base_model.dart';

class SplashViewModel extends BaseModel {
  final _authenticationService = locator<AuthenticationService>();

  final _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = null;
    // await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(HomeViewRoute);
    } else {
      _navigationService.navigateTo(LoginViewRoute);
    }
  }
}
