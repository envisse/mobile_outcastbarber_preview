part of '../barrel.dart';

class SettingsPage extends StatelessWidget {
  Future<int> showmodalLanguage(BuildContext context, int selected) async {
    //Language , 1 = English , 2 = Bahasa indonesia
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => Wrap(
            children: [
              RadioListTile(
                value: 1,
                groupValue: selected,
                title: TextComponent(text: 'English', textStyling: TextStyling.heading5),
                onChanged: (value) {
                  setState(() {
                    selected = int.parse(value.toString());
                  });
                },
              ),
              RadioListTile(
                value: 2,
                groupValue: selected,
                title: TextComponent(text: 'Bahasa Indonesia', textStyling: TextStyling.heading5),
                onChanged: (value) {
                  setState(() {
                    selected = int.parse(value.toString());
                  });
                },
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMargin),
                child: ButtonContainedComponent(
                    onPressed: () {
                      if (selected == 1)
                        context.read<LocaleCubit>().setLocale(Locale('en'));
                      else
                        context.read<LocaleCubit>().setLocale(Locale('id'));
                      Navigator.pop(context, true);
                    },
                    text:  AppLocalizations.of(context)!.global_save,
                    isIcon: false),
              )
            ],
          ),
        );
      },
    );
    return selected;
  }

  Future<String?> showPinSetup(BuildContext context) async {
    TextEditingController _pin = TextEditingController();
    //Language , 1 = English , 2 = Bahasa indonesia
    bool result = await BottomModalComponent().modal(
        context: context,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            TextComponent(
              text: AppLocalizations.of(context)!.settingPage_insertpin,
              textStyling: TextStyling.heading3,
              textcolor: ColorsPicker.SecondaryColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 40),
              child: PinCodeTextField(
                obscureText: true,
                appContext: context,
                length: 6,
                onChanged: (value) {},
                keyboardType: TextInputType.number,
                controller: _pin,
                pinTheme: PinTheme(activeColor: ColorsPicker.SecondaryColor, inactiveColor: ColorsPicker.SecondaryColor),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMargin),
              child: ButtonContainedComponent(
                  onPressed: () {
                    if (_pin.text.isEmpty) 
                      return;
                    Navigator.pop(context, true);
                  },
                  text: AppLocalizations.of(context)!.global_save,
                  isIcon: false),
            )
          ],
        ));
    if (result) {
      SnackBarComponent.snackbar(context, SnackbarStatus.success, AppLocalizations.of(context)!.settingPage_restartCommand);
      return _pin.text;
    }
    return _pin.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingPage_settings),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoadSuccess) {
            return Builder(
              builder: (context) => Wrap(
                children: [
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.settingPage_language),
                    subtitle: Text(AppLocalizations.of(context)!.settingPage_choosePreferredLanguage),
                    onTap: () async {
                      int selectedlanguage = await showmodalLanguage(context, state.settingsData.selectedLanguage);
                      context.read<SettingsCubit>().settingsUpdate(SettingsData(selectedlanguage, state.settingsData.isPin, state.settingsData.pin));
                    },
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.settingPage_pin),
                    subtitle: Text(AppLocalizations.of(context)!.settingPage_detailpin),
                    trailing: Switch(value: state.settingsData.isPin, onChanged: (value) {}),
                    onTap: () async {
                      if (state.settingsData.isPin == true) {
                        context.read<SettingsCubit>().settingsUpdate(SettingsData(state.settingsData.selectedLanguage, !state.settingsData.isPin, null));
                      } else {
                        String? pin = await showPinSetup(context);
                        if (pin != null)
                          context.read<SettingsCubit>().settingsUpdate(SettingsData(state.settingsData.selectedLanguage, !state.settingsData.isPin, pin));
                      }
                    },
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
