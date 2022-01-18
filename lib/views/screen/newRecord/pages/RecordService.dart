part of '../barrel.dart';

//PAGE
class RecordServicePage extends StatefulWidget {
  final List<Product> products;
  final List<Service> services;
  final List<Crew> crews;

  RecordServicePage({required this.products, required this.services, required this.crews});

  @override
  _RecordServicePageState createState() => _RecordServicePageState();
}

class _RecordServicePageState extends State<RecordServicePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  //all list selected
  List<Service> selectedservice = [];
  late int serviceprice;

  List<Product> selectedproduct = [];
  late int productprice;

  String? selectedbarber;
  int total = 0;
  TextEditingController _customer = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    super.build(context);
    var _sizeRow = MediaQuery.of(context).size.width / 8;
    //first column is for define 2 container with custom height in first container
    return Form(
        key: globalKey,
        child: Column(children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
            //CHOOSE CUSTOMER SECTION
            Container(
              margin: EdgeInsets.fromLTRB(Dimens.horizontalMargin, Dimens.verticalMargin, Dimens.horizontalMargin, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent(
                    text: localization.newRecord_service_costumerName,
                    textStyling: TextStyling.body,
                    textcolor: ColorsPicker.SecondaryColor,
                  ),
                  SizedBox(height: 10),
                  TextFieldComponent(
                    textEditingController: _customer,
                    labelText: localization.global_name,
                    validator: RequiredValidator(errorText: 'Required'),
                  ),
                ],
              ),
            ),

            //CHOOSE BARBER SECTION
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMargin),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextComponent(
                          text: localization.newRecord_service_barberName, textStyling: TextStyling.heading5, fontWeight: FontWeight.w500, textcolor: ColorsPicker.SecondaryColor),
                      SizedBox(height: 10),
                      DropdownButtonFormField(
                          validator: (value) => (value == null) ? 'Required' : null,
                          hint: Text(localization.newRecord_service_selectBarber),
                          isExpanded: true,
                          value: selectedbarber,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 30,
                          items: widget.crews
                              .map((e) => DropdownMenuItem(
                                  child: TextComponent(
                                    text: e.barber,
                                    textStyling: TextStyling.heading5,
                                  ),
                                  value: e.barber))
                              .toList(),
                          onChanged: (value) {
                              selectedbarber = value.toString();
                          }),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            //SECTION SERVICE SELECTED
            Container(
              height: 200,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMargin, vertical: 10),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Container(
                            width: _sizeRow * 2,
                            child: TextComponent(
                                text: localization.global_service, textStyling: TextStyling.body, fontWeight: FontWeight.w600, textcolor: ColorsPicker.PrimaryColor)),
                        Container(
                            width: _sizeRow,
                            child: TextComponent(
                                text: localization.global_amount, textStyling: TextStyling.body, fontWeight: FontWeight.w600, textcolor: ColorsPicker.PrimaryColor)),
                        Container(
                            width: _sizeRow,
                            child:
                                TextComponent(text: localization.global_price, textStyling: TextStyling.body, fontWeight: FontWeight.w600, textcolor: ColorsPicker.PrimaryColor)),
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
                                    text: selectedservice[index].name,
                                    textStyling: TextStyling.body,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Container(
                                  width: _sizeRow,
                                  child: TextComponent(
                                      text: selectedservice[index].amount.toString(),
                                      textAlign: TextAlign.start,
                                      textStyling: TextStyling.body,
                                      fontWeight: FontWeight.w600)),
                              Container(
                                  width: _sizeRow,
                                  child: TextComponent(
                                      text: selectedservice[index].totalprice.toString(),
                                      textStyling: TextStyling.body,
                                      textcolor: ColorsPicker.PrimaryColor,
                                      fontWeight: FontWeight.w600)),
                              Container(
                                  width: _sizeRow / 2,
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedservice.removeAt(index);
                                          total = totalPrice();
                                        });
                                      },
                                      icon: Icon(Icons.clear, color: ColorsPicker.ErrorColor)))
                            ]));
                      },
                      itemCount: selectedservice.length,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMargin),
                          child: ButtonContainedComponent(
                              onPressed: () async {
                                int? selected;
                                TextEditingController _amount = TextEditingController();
                                _amount.text = '1';

                                Service newService = await BottomModalComponent().modal(
                                    context: context,
                                    child: Wrap(runSpacing: 30, children: [
                                      TextComponent(text: localization.newRecord_service_addService, textStyling: TextStyling.heading3, textcolor: ColorsPicker.SecondaryColor),
                                      //FIELD DROPDOWN COMPONENTS
                                      DropdownButtonFormField(
                                          hint: Text(localization.newRecord_service_selectService),
                                          isExpanded: true,
                                          value: selected,
                                          icon: Icon(Icons.arrow_drop_down),
                                          iconSize: 24,
                                          elevation: 30,
                                          items: widget.services
                                              .asMap()
                                              .entries
                                              .map((e) => DropdownMenuItem(
                                                  child: TextComponent(text: '${e.value.name} ${CurrencyUtils.currencyIDRwoSymbol(e.value.price)}', textStyling: TextStyling.heading5),
                                                  value: e.key.toString()))
                                              .toList(),
                                          onChanged: (value) => selected = int.parse(value.toString())),
                                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        Container(
                                            child: TextComponent(text: localization.global_amount, textStyling: TextStyling.heading5, textcolor: ColorsPicker.SecondaryColor)),
                                        Row(children: [
                                          IconButton(onPressed: () => _amount.text = (int.parse(_amount.text) - 1).toString(), icon: Icon(Icons.remove)),
                                          Container(
                                              width: MediaQuery.of(context).size.width * 0.1,
                                              child: TextFormField(
                                                  controller: _amount,
                                                  textAlign: TextAlign.center,
                                                  keyboardType: TextInputType.phone,
                                                  decoration: InputDecoration(focusedBorder: InputBorder.none, enabledBorder: InputBorder.none))),
                                          IconButton(onPressed: () => _amount.text = (int.parse(_amount.text) + 1).toString(), icon: Icon(Icons.add)),
                                        ])
                                      ]),
                                      Container(
                                          height: 50,
                                          width: double.infinity,
                                          child: ButtonContainedComponent(
                                              onPressed: () {
                                                Navigator.pop(
                                                    context,
                                                    Service(
                                                      name: widget.services[selected!].name,
                                                      price: widget.services[selected!].price,
                                                      amount: int.parse(_amount.text),
                                                      totalprice: widget.services[selected!].price * int.parse(_amount.text),
                                                      id: '',
                                                    ));
                                              },
                                              text: localization.global_add,
                                              isIcon: false))
                                    ]));
                                setState(() {
                                  selectedservice.add(newService);
                                  total = totalPrice();
                                });
                              },
                              text: localization.global_add,
                              isIcon: true,
                              icon: Icon(Icons.add))),
                      ButtonContainedComponent(
                          onPressed: () async {
                            TextEditingController _amount = TextEditingController();
                            TextEditingController _name = TextEditingController();
                            TextEditingController _price = TextEditingController();
                            _amount.text = '1';
                            Service customService = await BottomModalComponent().modal(
                                context: context,
                                child: Wrap(runSpacing: 30, children: [
                                  TextComponent(text: localization.newRecord_service_customService, textStyling: TextStyling.heading3, textcolor: ColorsPicker.SecondaryColor),
                                  //Field custom service
                                  TextFieldComponent(textEditingController: _name, labelText: localization.newRecord_service_nameOfService),
                                  TextFieldComponent(textEditingController: _price, labelText: localization.global_price,keyboardtype: TextInputType.number),

                                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Container(child: TextComponent(text: localization.global_amount, textStyling: TextStyling.heading5, textcolor: ColorsPicker.SecondaryColor)),
                                    Row(children: [
                                      IconButton(onPressed: () => _amount.text = (int.parse(_amount.text) - 1).toString(), icon: Icon(Icons.remove)),
                                      Container(
                                          width: MediaQuery.of(context).size.width * 0.1,
                                          child: TextFormField(
                                              controller: _amount,
                                              textAlign: TextAlign.center,
                                              keyboardType: TextInputType.phone,
                                              decoration: InputDecoration(focusedBorder: InputBorder.none, enabledBorder: InputBorder.none))),
                                      IconButton(onPressed: () => _amount.text = (int.parse(_amount.text) + 1).toString(), icon: Icon(Icons.add)),
                                    ])
                                  ]),
                                  Container(
                                      height: 50,
                                      width: double.infinity,
                                      child: ButtonContainedComponent(
                                          onPressed: () {
                                            Navigator.pop(
                                                context,
                                                Service(
                                                  name: _name.text,
                                                  price: int.parse(_price.text),
                                                  amount: int.parse(_amount.text),
                                                  totalprice: int.parse(_price.text) * int.parse(_amount.text),
                                                  id: '',
                                                ));
                                          },
                                          text: localization.global_add,
                                          isIcon: false))
                                ]));
                            setState(() {
                              selectedservice.add(customService);
                              total = totalPrice();
                            });
                          },
                          text: localization.newRecord_service_customService,
                          isIcon: true,
                          icon: Icon(Icons.add))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            //SECTION SELECTED PRODUCT
            Container(
                height: 200,
                child: Column(children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMargin, vertical: 10),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Container(
                            width: _sizeRow * 2,
                            child: TextComponent(
                                text: localization.global_product, textStyling: TextStyling.body, fontWeight: FontWeight.w600, textcolor: ColorsPicker.PrimaryColor)),
                        Container(
                            width: _sizeRow,
                            child: TextComponent(
                                text: localization.global_amount, textStyling: TextStyling.body, fontWeight: FontWeight.w600, textcolor: ColorsPicker.PrimaryColor)),
                        Container(
                            width: _sizeRow,
                            child:
                                TextComponent(text: localization.global_price, textStyling: TextStyling.body, fontWeight: FontWeight.w600, textcolor: ColorsPicker.PrimaryColor)),
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
                                        text: selectedproduct[index].name,
                                        textStyling: TextStyling.body,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Container(
                                      width: _sizeRow,
                                      child: TextComponent(
                                          text: selectedproduct[index].amount.toString(),
                                          textAlign: TextAlign.start,
                                          textStyling: TextStyling.body,
                                          fontWeight: FontWeight.w600)),
                                  Container(
                                      width: _sizeRow,
                                      child: TextComponent(
                                          text: selectedproduct[index].totalprice.toString(),
                                          textStyling: TextStyling.body,
                                          textcolor: ColorsPicker.PrimaryColor,
                                          fontWeight: FontWeight.w600)),
                                  Container(
                                      width: _sizeRow / 2,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedproduct.removeAt(index);
                                              total = totalPrice();
                                            });
                                          },
                                          icon: Icon(Icons.clear, color: ColorsPicker.ErrorColor)))
                                ]));
                          },
                          itemCount: selectedproduct.length)),
                  //BUTTON ADD PRODUCT
                  Row(children: [
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMargin),
                        child: ButtonContainedComponent(
                            onPressed: () async {
                              int? selected;
                              TextEditingController _amount = TextEditingController();
                              _amount.text = '1';
                              Product newProduct = await BottomModalComponent().modal(
                                  context: context,
                                  child: Wrap(runSpacing: 30, children: [
                                    TextComponent(text: localization.newRecord_service_addProduct, textStyling: TextStyling.heading3, textcolor: ColorsPicker.SecondaryColor),
                                    //FIELD DROPDOWN COMPONENTS
                                    DropdownButtonFormField(
                                        hint: Text(localization.newRecord_service_selectProduct),
                                        isExpanded: true,
                                        value: selected,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 30,
                                        items: widget.products
                                            .asMap()
                                            .entries
                                            .map((e) => DropdownMenuItem(
                                                child: TextComponent(text: '${e.value.name} ${CurrencyUtils.currencyIDRwoSymbol(e.value.price)}', textStyling: TextStyling.heading5),
                                                value: e.key.toString()))
                                            .toList(),
                                        onChanged: (value) => selected = int.parse(value.toString())),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Container(
                                          child: TextComponent(text: localization.global_amount, textStyling: TextStyling.heading5, textcolor: ColorsPicker.SecondaryColor)),
                                      Row(children: [
                                        IconButton(onPressed: () => _amount.text = (int.parse(_amount.text) - 1).toString(), icon: Icon(Icons.remove)),
                                        Container(
                                            width: MediaQuery.of(context).size.width * 0.1,
                                            child: TextFormField(
                                                controller: _amount,
                                                textAlign: TextAlign.center,
                                                keyboardType: TextInputType.phone,
                                                decoration: InputDecoration(focusedBorder: InputBorder.none, enabledBorder: InputBorder.none))),
                                        IconButton(onPressed: () => _amount.text = (int.parse(_amount.text) + 1).toString(), icon: Icon(Icons.add)),
                                      ])
                                    ]),
                                    Container(
                                        height: 50,
                                        width: double.infinity,
                                        child: ButtonContainedComponent(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context,
                                                  Product(
                                                    name: widget.products[selected!].name,
                                                    price: widget.products[selected!].price,
                                                    amount: int.parse(_amount.text),
                                                    totalprice: widget.products[selected!].price * int.parse(_amount.text),
                                                    id: '',
                                                  ));
                                            },
                                            text: localization.global_add,
                                            isIcon: false))
                                  ]));
                              setState(() {
                                selectedproduct.add(newProduct);
                                total = totalPrice();
                              });
                            },
                            text: localization.global_add,
                            isIcon: true,
                            icon: Icon(Icons.add)))
                  ])
                ]))
          ]))),
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Column(children: [
                Divider(thickness: 2),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: Dimens.horizontalMargin),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(mainAxisSize: MainAxisSize.max, children: [
                        TextComponent(
                          text: localization.global_total,
                          textStyling: TextStyling.heading5,
                          fontWeight: FontWeight.w700,
                          textcolor: ColorsPicker.SecondaryColor,
                        ),
                        SizedBox(width: 30),
                        TextComponent(
                            text: NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(total),
                            textStyling: TextStyling.heading5,
                            fontWeight: FontWeight.w700,
                            textcolor: ColorsPicker.SecondaryColor)
                      ]),
                      //SAVE BUTTON
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: ButtonContainedComponent(
                              onPressed: () {
                                if (!globalKey.currentState!.validate() || !((selectedproduct.isNotEmpty || selectedservice.isNotEmpty))) {
                                  SnackBarComponent.snackbar(context, SnackbarStatus.error, localization.newRecord_service_error);
                                  return;
                                }
                                RecordServices recordService = RecordServices(
                                    nameCostumer: _customer.text,
                                    nameBarber: selectedbarber,
                                    date: DateTime.now(),
                                    totalprice: total,
                                    products: selectedproduct,
                                    services: selectedservice);
                                NewRecordScreen().newRecordService(context: context, recordServices: recordService);
                              },
                              text: localization.global_save,
                              isIcon: false))
                    ]))
              ]))
        ]));
  }

  //index => 1 : service , 2 : product
  //TODO : SIMPLIFY WITH THIS
  dynamic _addBotttomModal(BuildContext context, index) async {}

  int totalPrice() {
    int service = 0;
    int product = 0;
    selectedservice.forEach((element) {
      service += element.totalprice!;
    });
    selectedproduct.forEach((element) {
      product += element.totalprice!;
    });
    return total = service + product;
  }
}
