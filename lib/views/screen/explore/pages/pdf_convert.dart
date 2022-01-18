import 'package:flutter/material.dart';

class PdfConvert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF converter'),
        actions: [
          TextButton(
              onPressed: () async {
                // var data  = await PdfDataFeature().fetcData(DateTimeRange(start: DateTime.now(), end: DateTime.now()));
                // final pdfFile = await PdfRecapApi.generate(data);
                // PdfApi.openFile(pdfFile);
              },
              child: Text('Export PDF'))
        ],
      ),
      body: Container(),
    );
  }
}
