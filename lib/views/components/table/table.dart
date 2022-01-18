import 'package:flutter/material.dart';
import 'package:mobile_outcastbarber/views/components/text/text.dart';

// ignore: must_be_immutable
class TableComponent extends StatelessWidget {
  //must fill
  List<String> columns;
  List<DataRow> datarows;

  TableComponent({
    required this.columns,
    required this.datarows,
  });

  //mapping data columns
  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((String column) => DataColumn(label: TextComponent(text:column,textStyling: TextStyling.body,))).toList();

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: getColumns(columns),
      rows: datarows,
      dividerThickness: null,
      horizontalMargin: 0,
      dataRowHeight: 25,
    );
  }
}
