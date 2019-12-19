
import 'package:get_it/get_it.dart';
import 'package:harvest/api/api.dart';
import 'package:harvest/api/fake_api.dart';

import 'api/http_api.dart';

GetIt locator = GetIt.instance;

const bool USE_FAKE_IMPLEMENTATION = true;

void setupLocator() {
  locator.registerLazySingleton<Api>(() => USE_FAKE_IMPLEMENTATION ? FakeApi() : HttpApi());
}