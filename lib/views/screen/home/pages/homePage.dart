part of '../barrel.dart';

class HomePage extends StatelessWidget {
  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    final List<String> columnName = [localization.global_name, localization.global_service, localization.global_price];
    //LATEST SERVICE CARD
    double _sizeRow = (MediaQuery.of(context).size.width / 4) - Dimens.horizontalMargin;
    return BlocBuilder<RecaprecordCubit, RecaprecordState>(
      builder: (context, state) {
        if (state is RecaprecordLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is RecaprecordLoaded) {
          return SmartRefresher(
            controller: refreshController,
            onRefresh: () async {
              // monitor network fetch
              await Future.delayed(Duration(milliseconds: 1000));
              // if failed,use refreshFailed()
              context.read<RecaprecordCubit>().recaprecordload();
              refreshController.refreshCompleted();
            },
            child: Stack(
              children: [
                //layer 1 : background
                Container(
                    padding: EdgeInsets.only(top: Dimens.verticalMargin),
                    width: MediaQuery.of(context).size.width,
                    color: ColorsPicker.SecondaryColor,
                    child: Column(children: [
                      TextComponent(text: localization.homePage_todayEarn, textStyling: TextStyling.heading2, textcolor: Colors.white),
                      SizedBox(height: 10),
                      TextComponent(
                          text: NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                              .format(state.recordRecap.earnservice - state.recordRecap.earnwithdraw),
                          textStyling: TextStyling.heading3,
                          textcolor: Colors.white),
                      TextButton(
                          onPressed: () {
                            DateTimeRange dateTimeRange = DateTimeRange(start: DateTime.now(), end: DateTime.now());
                            context.read<PdfexportCubit>().generatePDF(dateTimeRange, [true, true, true]);
                          },
                          child: TextComponent(
                            text: localization.homePage_printTodayReport,
                            textStyling: TextStyling.heading5,
                            textcolor: ColorsPicker.WarningColor,
                          ))
                    ])),
                //layer 2 : container
                Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 10),
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.22),
                    decoration: BoxDecoration(
                        color: ColorsPicker.BackgroundColor1, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMargin),
                      child: Column(children: [
                        //Daliy Recap Card
                        CardComponent(
                            margin: EdgeInsets.fromLTRB(24, 10, 24, 20),
                            contain: Column(children: [
                              TextComponent(
                                  text: localization.homePage_dailyRecap, textStyling: TextStyling.heading4, fontWeight: FontWeight.w600, textcolor: ColorsPicker.PrimaryColor),
                              SizedBox(height: 20),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                TextComponent(text: localization.homePage_allService, textStyling: TextStyling.body, fontWeight: FontWeight.normal),
                                TextComponent(
                                    text: NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(state.recordRecap.earnservice),
                                    textStyling: TextStyling.body,
                                    fontWeight: FontWeight.normal,
                                    textcolor: ColorsPicker.SecondaryColor),
                              ]),
                              SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                TextComponent(text: localization.global_withdraw, textStyling: TextStyling.body, fontWeight: FontWeight.normal),
                                TextComponent(
                                    text: NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(state.recordRecap.earnwithdraw),
                                    textStyling: TextStyling.body,
                                    fontWeight: FontWeight.normal,
                                    textcolor: ColorsPicker.SecondaryColor),
                              ]),
                              SizedBox(height: 10),
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                TextComponent(text: localization.homePage_total, textStyling: TextStyling.body, fontWeight: FontWeight.normal),
                                TextComponent(
                                    text: NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                                        .format(state.recordRecap.earnservice - state.recordRecap.earnwithdraw),
                                    textStyling: TextStyling.body,
                                    fontWeight: FontWeight.normal,
                                    textcolor: ColorsPicker.SecondaryColor)
                              ]),
                            ])),
                        SizedBox(height: 20),
                        //Latest Service
                        CardComponent(
                            margin: EdgeInsets.fromLTRB(24, 10, 24, 20),
                            contain: Container(
                                height: MediaQuery.of(context).size.height * 0.2,
                                child: Column(children: [
                                  TextComponent(
                                      text: localization.homePage_latestService,
                                      textStyling: TextStyling.heading4,
                                      fontWeight: FontWeight.w600,
                                      textcolor: ColorsPicker.PrimaryColor),
                                  SizedBox(height: 20),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: columnName
                                          .map((e) => Container(
                                                width: _sizeRow,
                                                child: TextComponent(
                                                  text: e,
                                                  textStyling: TextStyling.body,
                                                  fontWeight: FontWeight.w600,
                                                  textcolor: ColorsPicker.PrimaryColor,
                                                ),
                                              ))
                                          .toList()),
                                  Divider(thickness: 2, color: Colors.black),
                                  Expanded(
                                      child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: 10);
                                    },
                                    itemBuilder: (context, index) {
                                      var data = state.recordRecap.record[index];
                                      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                        Container(width: _sizeRow, child: TextComponent(text: data.nameCostumer, textStyling: TextStyling.body)),
                                        Container(
                                            width: _sizeRow,
                                            child: TextComponent(
                                                text: (data.services.length > 1)
                                                    ? localization.homePage_multiTreatment
                                                    : (data.services.isEmpty)
                                                        ? data.products.first.name
                                                        : data.services.first.name,
                                                textAlign: TextAlign.start,
                                                textStyling: TextStyling.body)),
                                        Container(
                                            width: _sizeRow,
                                            child: TextComponent(
                                              text: NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(data.totalprice),
                                              textStyling: TextStyling.body,
                                              textcolor: ColorsPicker.PrimaryColor,
                                            ))
                                      ]);
                                    },
                                    itemCount: state.recordRecap.record.length,
                                  ))
                                ]))),
                      ]),
                    ))
              ],
            ),
          );
        }
        return Center(child: Text(localization.homePage_unknownError));
      },
    );
  }
}
