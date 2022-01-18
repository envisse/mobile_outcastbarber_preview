import 'package:flutter/material.dart';
import 'package:mobile_outcastbarber/routes/args/pin_args.dart';
import 'package:mobile_outcastbarber/routes/args/detail_args.dart';
import 'package:mobile_outcastbarber/routes/middleware/MiddlewareAuth.dart';
import 'package:mobile_outcastbarber/routes/middleware/pinAuth.dart';
import 'package:mobile_outcastbarber/views/screen/details/barrel.dart';
import 'package:mobile_outcastbarber/views/screen/export.dart';
import 'package:mobile_outcastbarber/views/screen/settings/barrel.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // for explore some feature
      // case ('/'):
      //   return MaterialPageRoute(
      //       builder: (context) => ExploreScreen());

      case ('/'):
       final PinArgs args = routeSettings.arguments as PinArgs;
        return MaterialPageRoute(
            builder: (context) => MiddlewareAuth(screen: PinAuth(screen: HomeScreen(),pinOk: args.pinOk,)));

      case ('/add_record'):
        return MaterialPageRoute(
            builder: (context) => MiddlewareAuth(screen: NewRecordScreen()));

      case ('/detail_service'):
        final args = routeSettings.arguments as DetailsArgs;
        return MaterialPageRoute(
            builder: (context) => MiddlewareAuth(
                screen:
                    DetailsScreen(screen: Screen.DetailsService, recordServices: args.recordServices,)));

      case ('/detail_withdraw'):
        final args = routeSettings.arguments as DetailsArgs;
        return MaterialPageRoute(
            builder: (context) => MiddlewareAuth(
                screen: DetailsScreen(
                    screen: Screen.DetailsWithdraw,recordWithdraws: args.recordWithdraws,)));

      case ('/offering'):
        return MaterialPageRoute(
            builder: (context) => MiddlewareAuth(screen: OfferingScreen()));

      case ('/pdf_report'):
        return MaterialPageRoute(
            builder: (context) => MiddlewareAuth(
                screen: PdfReport()));  

      case ('/crew_list'):
        return MaterialPageRoute(
            builder: (context) => MiddlewareAuth(
                screen: CrewList()));

      case ('/application_settings'):
        return MaterialPageRoute(
          builder: (context) => MiddlewareAuth(
            screen: Settings()));

      //Authentication screen
      case ('/signup'):
        return MaterialPageRoute(builder: (context) => SignUpScreen());

      default:
        return MaterialPageRoute(builder: (context) => NotFoundScreen());
    }
  }
}
