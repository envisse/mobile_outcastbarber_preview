part of '../barrel.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage>{

  DateTimeRange selectedDate =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

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
      context.read<Recordv2Cubit>().recordServiceInitial(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    var _sizeRow = MediaQuery.of(context).size.width / 5;

    return Column(children: [
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
                  text: localization.servicePage_listIn,
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
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
                width: _sizeRow,
                child: TextComponent(
                  text: localization.global_name,
                  textStyling: TextStyling.body,
                  fontWeight: FontWeight.w600,
                  textcolor: ColorsPicker.PrimaryColor,
                )),
            Container(
                width: _sizeRow * 1.5,
                child: TextComponent(
                  text: localization.global_service,
                  textStyling: TextStyling.body,
                  fontWeight: FontWeight.w600,
                  textcolor: ColorsPicker.PrimaryColor,
                )),
            Container(
                width: _sizeRow,
                child: TextComponent(
                  text: localization.global_price,
                  textStyling: TextStyling.body,
                  fontWeight: FontWeight.w600,
                  textcolor: ColorsPicker.PrimaryColor,
                )),
            Container(
              width: _sizeRow / 2,
              child: Container(),
            )
          ])),
      Divider(thickness: 3, color: Colors.black),
      Expanded(
          child: BlocBuilder<Recordv2Cubit, Recordv2State>(
        bloc: Recordv2Cubit()..recordServiceInitial(selectedDate),
        buildWhen: (previous, current) => true,
        builder: (context, state) {
          if (state is Recordv2Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is Recordv2ServiceLoaded) {
            return ListView.separated(
                separatorBuilder: (context, index) {
                  return Container();
                },
                itemBuilder: (context, index) {
                  var data = state.services[index];
                  return Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimens.horizontalMargin),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: _sizeRow,
                                child: TextComponent(
                                  text: data.nameCostumer,
                                  textStyling: TextStyling.body,
                                  fontWeight: FontWeight.w600,
                                )),
                            Container(
                              width: _sizeRow * 1.5,
                              child: TextComponent(
                                  text: (data.services.length > 1)
                                      ? localization.servicePage_multiTreatment
                                      : (data.services.isEmpty)
                                          ? data.products.first.name
                                          : data.services.first.name,
                                  textAlign: TextAlign.start,
                                  textStyling: TextStyling.body,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                                width: _sizeRow,
                                child: TextComponent(
                                    text: NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp ',
                                            decimalDigits: 0)
                                        .format(data.totalprice),
                                    textStyling: TextStyling.body,
                                    textcolor: ColorsPicker.PrimaryColor,
                                    fontWeight: FontWeight.w600)),
                            Container(
                              width: _sizeRow / 2,
                              child: IconButton(
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/detail_service',
                                      arguments:
                                          DetailsArgs(recordServices: data)),
                                  icon: Icon(Icons.more_vert),
                                  color: ColorsPicker.PrimaryColor),
                            )
                          ]));
                },
                itemCount: state.services.length);
          } else if (state is Recordv2Empty) {
            return Center(child: Text(localization.servicePage_noServiceReport));
          }
          return Center(child: Text("Error"));
        },
      ))
    ]);
  }


}
