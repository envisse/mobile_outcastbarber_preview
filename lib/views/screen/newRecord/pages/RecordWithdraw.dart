part of '../barrel.dart';

class RecordWithdrawPage extends StatefulWidget {
  final List<Crew> crews;
  const RecordWithdrawPage({required this.crews});

  @override
  _RecordWithdrawState createState() => _RecordWithdrawState();
}

class _RecordWithdrawState extends State<RecordWithdrawPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TextEditingController _title = TextEditingController();
  List<WithDraw> listwithdraws = [];

  String? selectedbarber;

  int total = 0;

  final globalkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    super.build(context);
    var _sizeRow = MediaQuery.of(context).size.width / 8;
    return Form(
      key: globalkey,
      child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMargin, vertical: Dimens.verticalMargin),
          child: Column(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponent(
                  text: localization.newRecord_withdraw_titleWithdraw,
                  textStyling: TextStyling.body,
                  textcolor: ColorsPicker.SecondaryColor,
                ),
                SizedBox(height: 5),
                TextFieldComponent(
                  textEditingController: _title,
                  labelText: localization.global_title,
                  validator: RequiredValidator(errorText: 'Required'),
                ),
                Divider(thickness: 2, height: 10)
              ],
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponent(
                    text: localization.newRecord_withdraw_barberName,
                    textStyling: TextStyling.heading5,
                    fontWeight: FontWeight.w500,
                    textcolor: ColorsPicker.SecondaryColor),
                SizedBox(height: 10),
                DropdownButtonFormField(
                    validator: (value) => (value == null) ? 'Required' : null,
                    hint: Text(localization.newRecord_withdraw_barberName),
                    isExpanded: true,
                    value: selectedbarber,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 30,
                    items: widget.crews
                        .map((e) => DropdownMenuItem(child: TextComponent(text: e.barber, textStyling: TextStyling.heading5), value: e.barber))
                        .toList(),
                    onChanged: (value) {
                      selectedbarber = value.toString();
                    }),
              ],
            ),
          ]),
        ),
        Expanded(
          child: Container(
            child: Column(children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMargin, vertical: 10),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Container(
                        width: _sizeRow * 2,
                        child: TextComponent(
                            text: localization.global_name, textStyling: TextStyling.body, fontWeight: FontWeight.w600, textcolor: ColorsPicker.PrimaryColor)),
                    Container(
                        width: _sizeRow,
                        child: TextComponent(
                            text: localization.global_amount,
                            textStyling: TextStyling.body,
                            fontWeight: FontWeight.w600,
                            textcolor: ColorsPicker.PrimaryColor)),
                    Container(
                        width: _sizeRow,
                        child: TextComponent(
                            text: localization.global_price, textStyling: TextStyling.body, fontWeight: FontWeight.w600, textcolor: ColorsPicker.PrimaryColor)),
                    Container(width: _sizeRow / 2, child: Container())
                  ])),
              Divider(thickness: 3, color: Colors.black),
              Expanded(
                  child: ListView.separated(
                separatorBuilder: (context, index) => Divider(thickness: 1),
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMargin),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Container(
                            width: _sizeRow * 2,
                            child: TextComponent(
                              text: listwithdraws[index].name,
                              textStyling: TextStyling.body,
                              fontWeight: FontWeight.w600,
                            )),
                        Container(
                            width: _sizeRow,
                            child: TextComponent(
                                text: listwithdraws[index].amount.toString(),
                                textAlign: TextAlign.start,
                                textStyling: TextStyling.body,
                                fontWeight: FontWeight.w600)),
                        Container(
                            width: _sizeRow,
                            child: TextComponent(
                                text: listwithdraws[index].total.toString(),
                                textStyling: TextStyling.body,
                                textcolor: ColorsPicker.PrimaryColor,
                                fontWeight: FontWeight.w600)),
                        Container(
                            width: _sizeRow / 2,
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    listwithdraws.removeAt(index);
                                    total = 0;
                                    listwithdraws.map((e) => total = total + e.total).toList();
                                  });
                                },
                                icon: Icon(Icons.clear, color: ColorsPicker.ErrorColor)))
                      ]));
                },
                itemCount: listwithdraws.length,
              ))
            ]),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMargin),
          alignment: Alignment.centerLeft,
          child: ButtonContainedComponent(
              onPressed: () {
                TextEditingController _price = TextEditingController();
                TextEditingController _amount = TextEditingController();
                _amount.text = '1';
                TextEditingController _nameitem = TextEditingController();
                BottomModalComponent().modal(
                  context: context,
                  child: Wrap(
                    runSpacing: 30,
                    children: [
                      TextComponent(
                          text: localization.newRecord_withdraw_whatYouBuying, textStyling: TextStyling.heading3, textcolor: ColorsPicker.SecondaryColor),
                      TextFieldComponent(
                        textEditingController: _nameitem,
                        labelText: localization.global_name,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: TextFieldComponent(textEditingController: _price, keyboardtype: TextInputType.phone, labelText: localization.global_price),
                          ),
                          Column(
                            children: [
                              TextComponent(text: localization.global_amount, textStyling: TextStyling.heading5, textcolor: ColorsPicker.SecondaryColor),
                              Row(
                                children: [
                                  IconButton(onPressed: () => _amount.text = (int.parse(_amount.text) - 1).toString(), icon: Icon(Icons.remove)),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    child: TextFormField(
                                      controller: _amount,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  IconButton(onPressed: () => _amount.text = (int.parse(_amount.text) + 1).toString(), icon: Icon(Icons.add)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                          height: 50,
                          width: double.infinity,
                          child: ButtonContainedComponent(
                              onPressed: () {
                                setState(() {
                                  listwithdraws.add(
                                      WithDraw(name: _nameitem.text, amount: int.parse(_amount.text), total: int.parse(_amount.text) * int.parse(_price.text)));
                                  total = 0;
                                  listwithdraws.map((e) => total = total + e.total).toList();
                                });
                                Navigator.pop(context);
                              },
                              text: localization.global_add,
                              isIcon: false))
                    ],
                  ),
                );
              },
              text: localization.global_add,
              isIcon: true,
              icon: Icon(Icons.add)),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Column(
            children: [
              Divider(thickness: 2),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextComponent(
                        text: '${localization.global_total}      ' + NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(total),
                        textStyling: TextStyling.heading5,
                        fontWeight: FontWeight.w700,
                        textcolor: ColorsPicker.SecondaryColor),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ButtonContainedComponent(
                            onPressed: () {
                              if (!globalkey.currentState!.validate() || !listwithdraws.isNotEmpty) {
                                SnackBarComponent.snackbar(context, SnackbarStatus.error, localization.newRecord_withdraw_error);
                                return;
                              }
                              RecordWithdraws recordWithdraw = RecordWithdraws(
                                title: _title.text,
                                price: total,
                                date: DateTime.now(),
                                withdraws: listwithdraws,
                                nameBarber: selectedbarber,
                              );
                              NewRecordScreen().newRecordWithdraw(context: context, recordWithdraws: recordWithdraw);
                            },
                            text: localization.global_save,
                            isIcon: false))
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
