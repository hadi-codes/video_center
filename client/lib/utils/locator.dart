import 'package:get_it/get_it.dart';
import 'package:gui/api/api.dart';

GetIt locator = GetIt.instance;
void setupLocatorServices() {
  locator.registerSingleton(VideoCenterApi());
}
