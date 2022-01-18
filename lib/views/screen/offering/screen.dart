part of 'barrel.dart';

class OfferingScreen extends StatelessWidget {
  final List<Widget> _pages = [ServiceList(), ProductList()];


  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    final List<String> _tabname = [localization.global_service, localization.global_product];
    return DefaultTabController(
      length: _pages.length,
      child: BlocProvider(
        create: (context) => OfferinglistCubit()..offeringInitial(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(localization.offering_new),
            bottom:
                TabBar(tabs: [for (final tabs in _tabname) Tab(text: tabs)]),
          ),
          body: TabBarView(children: _pages),
          resizeToAvoidBottomInset: false,
        ),
      ),
    );
  }
}