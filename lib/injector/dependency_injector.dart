import 'package:get_it/get_it.dart';
import 'package:login_lucasian/data/repositories/login_repository.dart';
import 'package:login_lucasian/domain/use_cases/login_use_case.dart';
import 'package:login_lucasian/domain/use_cases/use_case_to_base_64.dart';
import 'package:login_lucasian/remote_data_sources/fake_login_data_source.dart';
import 'package:login_lucasian/ui/pages/login/login_form_validator/login_form_validator.dart';
import 'package:login_lucasian/ui/pages/login/login_presenter.dart';

GetIt locator = GetIt.instance;

Future<void> setupInjector() async {
  locator.registerFactory(() => FakeLoginDataSource());

  locator.registerFactory(() => LoginRepository(
      loginDataSourceContract: locator.get<FakeLoginDataSource>()));

  locator.registerFactory(() => LoginUseCase(locator.get<LoginRepository>()));

  locator.registerFactory(() => UseCaseToBase64());
  locator.registerLazySingleton(() => LoginFormValidator());

  locator.registerFactory(() => LoginPresenter(locator.get<LoginUseCase>(),
      locator.get<LoginFormValidator>(), locator.get<UseCaseToBase64>()));
}
