part of '../barrel.dart';

class PdfExportPage extends StatefulWidget {
  @override
  _PdfExportPageState createState() => _PdfExportPageState();
}

class _PdfExportPageState extends State<PdfExportPage> {
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
    }
  }

  List<bool> checkvalue = [false, false, false];

  @override
  Widget build(BuildContext context) {
    AppLocalizations localization = AppLocalizations.of(context)!;
    List<String> checkboxtype = [
      localization.pdfExportPage_reportIncome,
      localization.pdfExportPage_reportWithdraw,
      localization.pdfExportPage_reportNetIncome,
    ];
    return Scaffold(
      appBar: AppBar(title: Text(localization.pdfExportPage_downloadReport)),
      body: BlocListener<PdfexportCubit, PdfexportState>(
        listener: (context, state) {
         if (state is PdfexportError) {
           SnackBarComponent.snackbar(context, SnackbarStatus.error,'Error');
         }
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: Dimens.horizontalMargin,
            vertical: Dimens.verticalMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Report date (datetimerange)
              Wrap(
                direction: Axis.vertical,
                spacing: 10,
                children: [
                  TextComponent(
                      text: localization.pdfExportPage_selectReportDate,
                      textStyling: TextStyling.heading4,
                      textcolor: ColorsPicker.SecondaryColor,
                      fontWeight: FontWeight.w600),
                  GestureDetector(
                      onTap: () => _selectDate(context),
                      child: TextComponent(
                          text:
                              '${DateFormat('d MMMM ').format(selectedDate.start)} - ${DateFormat('d MMMM ').format(selectedDate.end)}',
                          textStyling: TextStyling.heading4))
                ],
              ),
              Divider(thickness: 2, height: 40),
              //Report type (Checkbox)
              Wrap(
                direction: Axis.vertical,
                children: [
                  TextComponent(
                      text: localization.pdfExportPage_selectReportType,
                      textStyling: TextStyling.heading4,
                      textcolor: ColorsPicker.SecondaryColor,
                      fontWeight: FontWeight.w600),
                  Wrap(
                    direction: Axis.vertical,
                    spacing: 5,
                    children: checkboxtype
                        .asMap()
                        .entries
                        .map((e) => Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: checkvalue[e.key],
                                      onChanged: (value) {
                                        setState(() {
                                          checkvalue[e.key] = value!;
                                        });
                                      },
                                    ),
                                    Text(e.value)
                                  ],
                                ),
                              ],
                            ))
                        .toList(),
                  )
                ],
              ),
              Divider(thickness: 2, height: 40),
              Container(
                  width: double.infinity,
                  height: 40,
                  child: ButtonContainedComponent(
                      onPressed: () {
                        context.read<PdfexportCubit>().generatePDF(selectedDate, checkvalue);
                      }, text: localization.pdfExportPage_download, isIcon: false))
            ],
          ),
        ),
      ),
    );
  }
}
