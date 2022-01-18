part of '../barrel.dart';

class CrewListPage extends StatelessWidget {
  const CrewListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localization.crewListPage_barberList)),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: Dimens.horizontalMargin,
                vertical: Dimens.verticalMargin),
            alignment: FractionalOffset.centerLeft,
            child: ButtonContainedComponent(
              onPressed: () async {
                TextEditingController _name = TextEditingController();
                Crew newCrew = await BottomModalComponent().modal(
                  context: context,
                  child: Wrap(
                    runSpacing: 30,
                    children: [
                      TextComponent(
                          text: localization.crewListPage_newCrew,
                          textStyling: TextStyling.heading3,
                          textcolor: ColorsPicker.SecondaryColor),
                      TextFieldComponent(textEditingController: _name,labelText: 'Name',),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ButtonContainedComponent(
                            onPressed: () => Navigator.pop(context, Crew(barber: _name.text,id: '')),
                            text: localization.crewListPage_addNewCrew,
                            isIcon: false),
                      )
                    ],
                  ),
                );
                context.read<CrewCubit>().crewCreate(newCrew);
              },
              text: localization.crewListPage_addNewCrew,
              isIcon: true,
              icon: Icon(Icons.add),
            ),
          ),
          Divider(thickness: 2),
          Expanded(
            child: BlocConsumer<CrewCubit, CrewState>(
              listener: (context, state) {
              if (state is CrewCreate)
                SnackBarComponent.snackbar(context, SnackbarStatus.success, state.messeage);
              if (state is CrewDeleted)
                SnackBarComponent.snackbar(context, SnackbarStatus.success, state.message);
              if (state is CrewUpdate)
                SnackBarComponent.snackbar(context, SnackbarStatus.success, state.messeage);
              if (state is CrewError)
                SnackBarComponent.snackbar(context, SnackbarStatus.error, state.messeage);
              },
              builder: (context, state) {
                if (state is CrewLoaded) {
                  if (state.crew.isEmpty) {
                    return Center(child: Text(localization.global_empty));
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) => Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Text(state.crew[index].barber),
                            trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                        leading: Icon(Icons.edit),
                                        title: Text(localization.global_edit,))),
                                PopupMenuItem(
                                    value: 2,
                                    child: ListTile(
                                        leading: Icon(Icons.delete),
                                        title: Text(localization.global_delete)))
                              ],
                              onSelected: (value) async {
                                if (value == 1) {
                                  TextEditingController _name = TextEditingController();
                                  _name.text = state.crew[index].barber;
                                  Crew updateCrew = await BottomModalComponent().modal(
                                    context: context,
                                    child: Wrap(
                                      runSpacing: 30,
                                      children: [
                                        TextComponent(
                                            text: localization.crewListPage_updateCrew,
                                            textStyling: TextStyling.heading3,
                                            textcolor:ColorsPicker.SecondaryColor),
                                        TextFieldComponent(textEditingController: _name,labelText: 'Name'),
                                        Container(
                                          height: 50,
                                          width: double.infinity,
                                          child: ButtonContainedComponent(
                                              onPressed: () => Navigator.pop(
                                                  context,
                                                  Crew(barber: _name.text,id: '')),
                                              text: localization.crewListPage_updateCrew,
                                              isIcon: false),
                                        )
                                      ],
                                    ),
                                  );
                                  context.read<CrewCubit>().crewUpdated(id: state.crew[index].id, crew: updateCrew);
                                  return;
                                }
                                context.read<CrewCubit>().crewDeleted(id: state.crew[index].id);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    itemCount: state.crew.length,
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }
}
