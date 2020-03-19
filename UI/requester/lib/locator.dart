import 'package:get_it/get_it.dart';
import 'package:requester/services/api_service.dart';
import 'package:requester/services/authentication_service.dart';
import 'package:requester/services/navigation_service.dart';
import 'package:requester/services/dialog_service.dart';
import 'package:requester/services/web_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => WebService());
}
