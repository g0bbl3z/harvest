import 'package:get_it/get_it.dart';
import 'package:harvest/api/fake_api.dart';
import 'package:harvest/api/http_api.dart';
import 'package:harvest/controllers/LoginController.dart';

GetIt locator = GetIt.instance;

const bool USE_FAKE_IMPLEMENTATION = true;

void setupLocator() {
  locator.registerLazySingleton(() => LoginController());
  locator.registerLazySingleton(() => USE_FAKE_IMPLEMENTATION ? FakeApi() : HttpApi());
}