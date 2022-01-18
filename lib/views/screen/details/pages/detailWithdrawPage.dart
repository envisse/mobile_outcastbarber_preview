part of '../barrel.dart';

// ignore: must_be_immutable
class DetailsWithdrawPage extends StatelessWidget {
  final RecordWithdraws recordWithdraws;
  DetailsWithdrawPage({required this.recordWithdraws});

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    List<String> _cardlist = [localization.detailsPage_withdraw_nameBarber];
    List<String?> _namelist = [recordWithdraws.nameBarber];
    return Scaffold(
      appBar: AppBar(title: Text(localization.detailsPage_withdraw_detailWithdraw)),
      body: Container(
        color: ColorsPicker.BackgroundColor1,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
            horizontal: Dimens.horizontalMargin,
            vertical: Dimens.verticalMargin),
        child: Column(
          children: [
            CardComponent(
                contain: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextComponent(
                              text: DateFormat('d MMM y * hh:mm aaa')
                                  .format(recordWithdraws.date),
                              textStyling: TextStyling.body),
                          Divider(thickness: 2, height: 20),
                          Builder(builder: (context) {
                            return Wrap(
                                runSpacing: 10,
                                children: _cardlist.asMap().entries.map((e) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextComponent(
                                          text: e.value,
                                          textStyling: TextStyling.body),
                                      TextComponent(
                                          text: _namelist[e.key]!,
                                          textStyling: TextStyling.body,
                                          fontWeight: FontWeight.bold)
                                    ],
                                  );
                                }).toList());
                          })
                        ]))),
            SizedBox(height: 20),
            CardComponent(
              contain: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                        text: localization.detailsPage_withdraw_detailWithdraw,
                        textStyling: TextStyling.heading5,
                        fontWeight: FontWeight.w700,
                        textcolor: ColorsPicker.SecondaryColor),
                    Divider(thickness: 2, height: 20),
                    Wrap(
                        runSpacing: 10,
                        children: recordWithdraws.withdraws.map((e) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextComponent(
                                  text: e.name + ' x ${e.amount}',
                                  textStyling: TextStyling.body),
                              TextComponent(
                                  text: NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp ',
                                          decimalDigits: 0)
                                      .format(e.total),
                                  textStyling: TextStyling.body,
                                  fontWeight: FontWeight.bold,
                                  textcolor: ColorsPicker.SecondaryColor),
                            ],
                          );
                        }).toList()),
                    Spacer(flex: 3),
                    Divider(thickness: 2, height: 40),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextComponent(
                              text: localization.global_total,
                              textStyling: TextStyling.heading5,
                              fontWeight: FontWeight.w700,
                              textcolor: ColorsPicker.SecondaryColor),
                          TextComponent(
                              text: NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp ',
                                      decimalDigits: 0)
                                  .format(recordWithdraws.price),
                              textStyling: TextStyling.heading5,
                              fontWeight: FontWeight.w700,
                              textcolor: ColorsPicker.SecondaryColor)
                        ])
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
