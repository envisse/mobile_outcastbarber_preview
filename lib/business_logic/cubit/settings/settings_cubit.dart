import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_outcastbarber/models/settingsdata.dart';
import 'package:mobile_outcastbarber/services/api/settings_api.dart';

part 'settings_state.dart';

//this state management is for handle user settings data
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  void settingsLoad()async{
    SettingsData settingsData = await SettingsApi.settingsLoad();
    emit(SettingsLoadSuccess(settingsData));
  }

  void settingsUpdate(SettingsData settingsData)async{
    SettingsApi.settingsUpdate(settingsData);
    settingsLoad();
  }
}
