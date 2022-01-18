part of 'barrel.dart';

class NewRecordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    final List<String> _tabname = [localization.global_service, localization.global_withdraw];
    return DefaultTabController(
      length: _tabname.length,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => OfferinglistCubit()..offeringInitial(),
          ),
          BlocProvider(
            create: (context) => CrewCubit()..crewLoaded(),
          ),
        ],
        child: BlocBuilder<OfferinglistCubit, OfferinglistState>(
          builder: (context, state) {
            if (state is OfferingListLoaded) {
              var dataproducts = state.products;
              var dataservices = state.services;
              return BlocBuilder<CrewCubit, CrewState>(
                builder: (context, state) {
                  if (state is CrewLoaded) {
                    var datacrew = state.crew;
                    return Scaffold(
                      appBar: AppBar(
                        title: Text(localization.newRecord),
                        bottom: TabBar(tabs: [
                          for (final tabs in _tabname) Tab(text: tabs)
                        ]),
                      ),
                      body: TabBarView(children: [
                        RecordServicePage(products: dataproducts, services: dataservices, crews: datacrew,),
                        RecordWithdrawPage(crews: datacrew,)
                      ]),
                      resizeToAvoidBottomInset: false);
                  }
                  return Scaffold(body: Center(child: CircularProgressIndicator()));
                },
              );
            }
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }

  void newRecordService(
      {required BuildContext context,
      required RecordServices recordServices}) async {
    //for close keyboard widget
    FocusScope.of(context).unfocus();

    DialogsComponents().confirmation(
      context: context,
      function: () async {
        //close confirmation dialog
        Navigator.pop(context);

        var createrecodservice = await RecordV2()
            .createRecordService(recordServices: recordServices);
        if (createrecodservice == true) {
          SnackBarComponent.snackbar(
              context, SnackbarStatus.success, AppLocalizations.of(context)!.newRecord_successAddingNewRecord);
          Navigator.pop(context);
          return null;
        }
        SnackBarComponent.snackbar(
            context, SnackbarStatus.error, AppLocalizations.of(context)!.newRecord_somethingWrong);
      },
    );
  }

  void newRecordWithdraw(
      {required BuildContext context,
      required RecordWithdraws recordWithdraws}) async {
    //for close keyboard widget
    FocusScope.of(context).unfocus();

    DialogsComponents().confirmation(
      context: context,
      function: () async {
        //close confirmation dialog
        Navigator.pop(context);
        var createrecordwithdraw = await RecordV2()
            .createRecordWithdraw(recordWithdraw: recordWithdraws);
        if (createrecordwithdraw == true) {
          SnackBarComponent.snackbar(
              context, SnackbarStatus.success, AppLocalizations.of(context)!.newRecord_successAddingNewRecord);
          Navigator.pop(context);
          return null;
        }
        SnackBarComponent.snackbar(
            context, SnackbarStatus.error, AppLocalizations.of(context)!.newRecord_somethingWrong);
      },
    );
  }
}
