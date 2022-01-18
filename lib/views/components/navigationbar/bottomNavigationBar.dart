import 'package:flutter/material.dart';
import 'package:mobile_outcastbarber/views/shared/colors.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavigationBarComponent extends StatelessWidget {
  final Function(int) onTap;
  final int activeIndex;
  BottomNavigationBarComponent({required this.onTap, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    final List<TabItem<dynamic>> items = [
      TabItem(icon: Icons.home, title: localization.bottomNavigationBar_home),
      TabItem(icon: Icons.map, title: localization.global_service),
      TabItem(icon: Icons.add), // center
      TabItem(icon: Icons.message, title: localization.global_withdraw),
      TabItem(icon: Icons.message, title: localization.bottomNavigationBar_stock),
    ];
    return ConvexAppBar(
      items: items,
      onTap: onTap,
      initialActiveIndex: activeIndex,
      backgroundColor: Colors.white,
      activeColor: ColorsPicker.PrimaryColor,
      color: ColorsPicker.SecondaryColor,
      style: TabStyle.fixedCircle,
      top: -15,
    );
  }
}
