import 'package:firebase_code_challenge/features/registration/presentation/viewmodels/registration_view_model.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //View models
  _loadViewModels();
}

_loadViewModels() {
  sl.registerFactory(() => RegistrationViewModel());
}
