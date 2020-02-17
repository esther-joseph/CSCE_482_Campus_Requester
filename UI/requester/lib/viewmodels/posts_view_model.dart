import 'package:requester/constants/route_names.dart';
import 'package:requester/locator.dart';
import 'package:requester/services/navigation_service.dart';
import 'package:requester/viewmodels/base_model.dart';

class PostsViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateToCreateView() =>
      _navigationService.navigateTo(CreatePostViewRoute);
}
