import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mobile_outcastbarber/localization/locale_logic/locale_cubit.dart';
import 'package:mobile_outcastbarber/localization/l10n.dart';
import 'package:mobile_outcastbarber/routes/app_route.dart';
import 'package:mobile_outcastbarber/routes/args/pin_args.dart';
import 'package:mobile_outcastbarber/views/shared/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => LocaleCubit(), child: MyAppWidget());
  }
}

class MyAppWidget extends StatelessWidget {
  final AppRoute _appRoute = AppRoute();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        context.read<LocaleCubit>().loadLocale();
        print(state);
        if (state is LocaleLoaded) {
          return MaterialApp(
            theme: themeData(),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: state.locale,
            supportedLocales: L10n.supportedlang,
            onGenerateRoute: _appRoute.onGenerateRoute,
            onGenerateInitialRoutes: (String initialRoute) {
              return [
                _appRoute.onGenerateRoute(RouteSettings(name: '/', arguments: PinArgs(pinOk: false)))!,
              ];
            },
            builder: EasyLoading.init(),
          );
        }
        return Container();
      },
    );
  }
}
