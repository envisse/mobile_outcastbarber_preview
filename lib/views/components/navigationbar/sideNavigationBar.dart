import 'package:flutter/material.dart';
import 'package:mobile_outcastbarber/services/repository/firebase/authentication.dart';
import 'package:mobile_outcastbarber/views/components/text/text.dart';
import 'package:mobile_outcastbarber/views/shared/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SideNavigationBar extends StatelessWidget {
  const SideNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ColorsPicker.SecondaryColor, ColorsPicker.ThirdColor],
          ),
        ),
        child: SafeArea(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 20),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/LOGO.png'),
                      radius: 40,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            //TODO:Next version 1.0
              // ListTile(
              //   // onTap: () => Navigator.pushReplacementNamed(context, '/logout'),
              //   onTap: () {},
              //   leading: Icon(
              //     Icons.person,
              //     color: Colors.white,
              //   ),
              //   title: TextComponent(
              //     textStyling: TextStyling.heading4,
              //     text: 'My Account',
              //     textcolor: Colors.white,
              //   ),
              // ),
              ListTile(
                onTap: () => Navigator.pushNamed(context, '/offering'),
                leading: Icon(
                  Icons.inventory_2,
                  color: Colors.white,
                ),
                title: TextComponent(
                  textStyling: TextStyling.heading4,
                  text: localization.sideNavagiationBar_offeringList,
                  textcolor: Colors.white,
                ),
              ),
              ListTile(
                onTap: () => Navigator.pushNamed(context, '/crew_list'),
                leading: Icon(
                  Icons.groups,
                  color: Colors.white,
                ),
                title: TextComponent(
                  textStyling: TextStyling.heading4,
                  text: localization.sideNavagiationBar_barber,
                  textcolor: Colors.white,
                ),
              ),
              ListTile(
                onTap: () => Navigator.pushNamed(context, '/pdf_report'),
                leading: Icon(
                  Icons.cloud_download,
                  color: Colors.white,
                ),
                title: TextComponent(
                  textStyling: TextStyling.heading4,
                  text: localization.sideNavagiationBar_downloadReport,
                  textcolor: Colors.white,
                ),
              ),
              ListTile(
                onTap: () => Navigator.pushNamed(context, '/application_settings'),
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: TextComponent(
                  textStyling: TextStyling.heading4,
                  text: localization.sideNavagiationBar_settings,
                  textcolor: Colors.white,
                ),
              ),
              ListTile(
                onTap: () =>
                    context.read<AuthenticationService>().signout(context),
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: TextComponent(
                  textStyling: TextStyling.heading4,
                  text: localization.sideNavagiationBar_logout,
                  textcolor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
