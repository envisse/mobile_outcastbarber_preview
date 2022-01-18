part of '../barrel.dart';

class WithdrawPage extends StatefulWidget {
  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage>  {

  DateTimeRange selectedDate = DateTimeRange(start: DateTime.now(), end: DateTime.now());

  //DATE PICKER
  _selectDate(BuildContext context) async {
    final pickedDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: selectedDate);

    if (pickedDateRange != null && pickedDateRange != selectedDate) {
      setState(() {
        selectedDate = pickedDateRange;
      });
      // context.read<Recordv2Cubit>().recordServiceInitial(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    var _sizeRow = MediaQuery.of(context).size.width / 5;

    return Column(
      children: [
        //WIDGET FOR SECTION FILTER
      Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(
              vertical: 20, horizontal: Dimens.horizontalMargin),
          child: Wrap(
            direction: Axis.vertical,
            spacing: 10,
            children: [
              TextComponent(
                  text: localization.withdrawPage_listIn,
                  textStyling: TextStyling.heading4,
                  textcolor: ColorsPicker.SecondaryColor,
                  fontWeight: FontWeight.w600),
              GestureDetector(
                  onTap: () => _selectDate(context),
                  child: TextComponent(
                      text:'${DateFormat('d MMMM ').format(selectedDate.start)} - ${DateFormat('d MMMM ').format(selectedDate.end)}',
                      textStyling: TextStyling.heading4))
            ],
          )),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Dimens.horizontalMargin, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: _sizeRow,
                child: TextComponent(
                  text: localization.global_title,
                  textStyling: TextStyling.body,
                  fontWeight: FontWeight.w600,
                  textcolor: ColorsPicker.PrimaryColor,
                ),
              ),
              Container(width: _sizeRow * 1.5, child: Container()),
              Container(
                width: _sizeRow,
                child: TextComponent(
                  text: localization.global_price,
                  textStyling: TextStyling.body,
                  fontWeight: FontWeight.w600,
                  textcolor: ColorsPicker.PrimaryColor,
                ),
              ),
              Container(
                width: _sizeRow / 2,
                child: Container(),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 3,
          color: Colors.black,
        ),
        Expanded(
            child: BlocBuilder<Recordv2Cubit, Recordv2State>(
          bloc: Recordv2Cubit()..recordWIthdrawsInitial(selectedDate),
          builder: (context, state) {
            if (state is Recordv2Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is Recordv2WithdrawLoaded) {
              return ListView.separated(
                  separatorBuilder: (context, index) {
                    return Container();
                  },
                  itemBuilder: (context, index) {
                    var data = state.withdraws[index];
                    return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimens.horizontalMargin),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: _sizeRow * 1.5,
                              child: TextComponent(
                                text: data.title,
                                textStyling: TextStyling.body,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(width: _sizeRow, child: Container()),
                            Container(
                              width: _sizeRow,
                              child: TextComponent(
                                  text: NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp ',
                                          decimalDigits: 0)
                                      .format(data.price),
                                  textStyling: TextStyling.body,
                                  textcolor: ColorsPicker.PrimaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              width: _sizeRow / 2,
                              child: IconButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/detail_withdraw',
                                      arguments: DetailsArgs(recordWithdraws: data)),
                                  icon: Icon(Icons.more_vert),
                                  color: ColorsPicker.PrimaryColor),
                            )
                          ],
                        ));
                  },
                  itemCount: state.withdraws.length);
            } else if (state is Recordv2Empty) {
              return Center(child: Text(localization.withdrawPage_noWithdrawReport));
            }
            return Center(child: Text('Bloc Error'));
          },
        ))
      ],
    );
  }


}
