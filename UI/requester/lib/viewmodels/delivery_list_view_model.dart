import 'package:requester/constants/route_names.dart';
import 'package:requester/locator.dart';
import 'package:requester/models/post.dart';
import 'package:requester/services/api_service.dart';
import 'package:requester/services/dialog_service.dart';
import 'package:requester/services/navigation_service.dart';
import 'package:requester/viewmodels/base_model.dart';

class DeliveryListViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final ApiService _apiService = locator<ApiService>();

  List<Post> _posts;

  List<Post> get posts => _posts;

  Future fetchPosts() async {
    setBusy(true);
    var postResults = await _apiService.getPosts();
    setBusy(false);

    if (postResults is List<Post>) {
      _posts = postResults;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
          title: 'Posts update Failed', description: postResults);
    }
  }

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(CreatePostViewRoute);
    await fetchPosts();
  }
}
