import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:proker/src/core/blocs/theme/theme_bloc.dart';
import 'package:proker/src/core/config/injection/injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getIt.init();

void setup() {
  getIt.registerFactory<ThemeBloc>(() => ThemeBloc());
}
