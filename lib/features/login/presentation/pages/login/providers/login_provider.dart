import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:login_lucasian/core/error/dio/factory/dio_error_message_factory.dart';
import 'package:login_lucasian/features/login/data/remote_data_sources/login_data_source.dart';
import 'package:login_lucasian/features/login/data/repositories/login_repository.dart';
import 'package:login_lucasian/features/login/domain/use_cases/login_use_case.dart';
import 'package:login_lucasian/features/login/domain/use_cases/use_case_to_base_64.dart';
import 'package:login_lucasian/features/login/presentation/pages/login/login_form_validator/login_form_validator.dart';
import 'package:login_lucasian/features/login/presentation/pages/login/login_presenter.dart';

GetIt sl = GetIt.instance;

Future<void> setUpLoginProviders() async {
  sl.registerLazySingleton(() => DioErrorMessageFactory());

  sl.registerFactory(() => LoginDataSource(dio: sl.get<Dio>()));

  sl.registerFactory(() => LoginRepository(
      loginDataSourceContract: sl.get<LoginDataSource>(),
      dioErrorMessageFactoryContract: sl.get<DioErrorMessageFactory>()));

  sl.registerFactory(() => LoginUseCase(sl.get<LoginRepository>()));

  sl.registerFactory(() => UseCaseToBase64());
  sl.registerLazySingleton(() => LoginFormValidator());

  sl.registerFactory(() => LoginPresenter(sl.get<LoginUseCase>(),
      sl.get<LoginFormValidator>(), sl.get<UseCaseToBase64>()));
}
