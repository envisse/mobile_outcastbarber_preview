part of '../barrel.dart';

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: Dimens.horizontalMargin,
              vertical: Dimens.verticalMargin),
          alignment: FractionalOffset.centerLeft,
          child: ButtonContainedComponent(
            onPressed: () async{
              TextEditingController _name = TextEditingController();         
              TextEditingController _price = TextEditingController();
              var globalkey = GlobalKey<FormState>();
              Product newProduct = await BottomModalComponent().modal(
                  context: context,
                  child: Form(
                    key: globalkey,
                    child: Wrap(
                      runSpacing: 30,
                      children: [
                        TextComponent(text: localization.offering_product_new,textStyling: TextStyling.heading3, textcolor: ColorsPicker.SecondaryColor),
                        TextFieldComponent(textEditingController: _name, labelText: localization.offering_product_name,validator: RequiredValidator(errorText: 'Required')),
                        TextFieldComponent(textEditingController: _price, labelText: localization.global_price,keyboardtype: TextInputType.phone,validator: RequiredValidator(errorText: 'Required')),
                        Container(
                          height: 50, width: double.infinity,
                          child: ButtonContainedComponent(
                              onPressed:() {
                                if (!globalkey.currentState!.validate()) {                                  
                                  return;
                                }
                                Navigator.pop(context,Product(name: _name.text, price: int.parse(_price.text),id: ''));
                              } ,
                              text: localization.global_save,
                              isIcon: false
                            ),
                          )
                        ],
                    ),
                  ));
              context.read<OfferinglistCubit>().createOffering(offeringList: OfferingList.product,product:newProduct);
            },
            text: localization.offering_product_add_new,
            isIcon: true,
            icon: Icon(Icons.add),
          ),
        ),
        Divider(thickness: 2),
        Expanded(
            child: BlocConsumer<OfferinglistCubit, OfferinglistState>(
          listener: (context, state) {
            if (state is OfferingCreate)
              SnackBarComponent.snackbar(context, SnackbarStatus.success, state.message);
            if (state is OfferingDelete)
              SnackBarComponent.snackbar(context, SnackbarStatus.success, state.message);
            if (state is OfferingUpdate)
              SnackBarComponent.snackbar(context, SnackbarStatus.success, state.message);
            if (state is OfferingError)
              SnackBarComponent.snackbar(context, SnackbarStatus.error, state.error);
          },
          builder: (context, state) {
            if (state is OfferingListLoaded) {
              if (state.products.isEmpty) {
                return Center(child: Text(localization.global_empty));
              }
              return ListView.builder(
                itemBuilder: (context, index) => Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(state.products[index].name),
                        subtitle: Text(NumberFormat.currency(
                                locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                            .format(state.products[index].price)),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text(localization.global_edit))),
                            PopupMenuItem(
                                value: 2,
                                child: ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text(localization.global_delete)))
                          ],
                          onSelected: (value) async {
                            if (value == 1) {
                              //EDIT BUTTON
                              TextEditingController _name =
                                  TextEditingController();
                              _name.text = state.products[index].name;
                              TextEditingController _price =
                                  TextEditingController();
                              _price.text =
                                  state.products[index].price.toString();
                              Product updated = await BottomModalComponent().modal(
                                  context: context,
                                  child: Wrap(
                                    runSpacing: 30,
                                    children: [
                                      TextComponent(text:localization.offering_product_edit_product,textStyling: TextStyling.heading3, textcolor: ColorsPicker.SecondaryColor),
                                      TextFieldComponent(textEditingController: _name,labelText: localization.offering_product_name),
                                      TextFieldComponent(textEditingController: _price,keyboardtype: TextInputType.phone,labelText: localization.global_price),
                                      Container(
                                        height: 50, width: double.infinity,
                                        child: ButtonContainedComponent(
                                            onPressed:() => Navigator.pop(context,Product(name: _name.text, price: int.parse(_price.text),id: '')),
                                            text: localization.global_save,
                                            isIcon: false
                                          ),
                                        )
                                      ],
                                    ),);
                              context.read<OfferinglistCubit>().offeringUpdated(offeringList: OfferingList.product, id: state.products[index].id, product: updated);
                              return;
                            }
                            //DELETE BUTTON
                            context.read<OfferinglistCubit>().offeringDeleted(offeringList: OfferingList.product,id: state.products[index].id);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                itemCount: state.products.length,
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ))
      ],
    );
  }
}
