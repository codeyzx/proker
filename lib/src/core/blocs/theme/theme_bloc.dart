import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ToggleThemeEvent extends ThemeEvent {}

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(false)) {
    on<LightThemeEvent>(_lightTheme);
    on<DarkThemeEvent>(_darkTheme);
    on<ToggleThemeEvent>(_toggleTheme);
  }

  Future _lightTheme(LightThemeEvent event, Emitter emit) async {
    emit(const ThemeState(false));
  }

  Future _darkTheme(DarkThemeEvent event, Emitter emit) async {
    emit(const ThemeState(true));
  }

  Future _toggleTheme(ToggleThemeEvent event, Emitter emit) async {
    emit(ThemeState(!state.isDarkMode));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }
}
