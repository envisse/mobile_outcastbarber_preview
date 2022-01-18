part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoadSuccess extends SettingsState {
  final SettingsData settingsData;

  SettingsLoadSuccess(this.settingsData);

  @override
  List<Object> get props => [settingsData];
}
