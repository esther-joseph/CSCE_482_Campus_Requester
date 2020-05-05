import 'package:requester/constants/route_names.dart';
import 'package:requester/locator.dart';
import 'package:requester/models/order.dart';
import 'package:requester/models/post.dart';
import 'package:requester/services/api_service.dart';
import 'package:requester/services/dialog_service.dart';
import 'package:requester/services/flutter_store_service.dart';
import 'package:requester/services/navigation_service.dart';
import 'package:requester/viewmodels/base_model.dart';

class OrderListViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final ApiService _apiService = locator<ApiService>();
  final FlutterStoreService _flutterStoreSerice =
      locator<FlutterStoreService>();

  List<Order> _orders;

  Future<void> init() async {
    this._orders = await _flutterStoreSerice.getOrders();
    notifyListeners();
  }

  List<Order> get orders => _orders;
}
