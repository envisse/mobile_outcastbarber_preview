import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_outcastbarber/business_logic/cubit/settings/settings_cubit.dart';
import 'package:mobile_outcastbarber/views/screen/export.dart';

class PinAuth extends StatelessWidget {
  final Widget screen;
  final bool pinOk;
 
  const PinAuth({Key? key, required this.screen,required this.pinOk});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit()..settingsLoad(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoadSuccess) {
            if (state.settingsData.isPin && pinOk == false){
              return VerificationScreen(setPin: state.settingsData.pin!,);
            }
            return screen;
          }
          return screen;
        },
      ),
    );
  }
}
