import 'package:get_it/get_it.dart';
import 'package:localstore/localstore.dart';
import 'package:image_picker/image_picker.dart';

final getItInjector = GetIt.instance;

void init() {
  final db = Localstore.instance;
  getItInjector.registerLazySingleton(() => db);

  getItInjector.registerLazySingleton(() => ImagePicker());
}
