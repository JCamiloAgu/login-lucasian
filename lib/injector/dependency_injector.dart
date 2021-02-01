import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:login_lucasian/features/login/presentation/pages/login/providers/login_provider.dart';

GetIt sl = GetIt.instance;

Future<void> setupInjector() async {
  sl.registerLazySingleton(() => Dio());

  await setUpLoginProviders();
}
