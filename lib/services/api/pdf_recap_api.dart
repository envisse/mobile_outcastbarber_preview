import 'dart:io';
import 'package:intl/intl.dart';
import 'package:mobile_outcastbarber/models/pdf/pdfData.dart';
import 'package:mobile_outcastbarber/services/api/pdf_api.dart';
import 'package:mobile_outcastbarber/utils/currency.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfRecapApi {
  static Future<File> generate(PdfData pdfData, List<bool> reportType) async {
    final pdf = Document();
    pdf.addPage(
      MultiPage(
        pageFormat: PdfPageFormat.a4,
        maxPages: 40,
        build: (context) => [
          buildHeader(pdfData),
          Divider(thickness: 2, height: 40),
          //SERVICE
          (reportType[0] == true) ? buildSubheader('Laporan Service & Penjualan') : SizedBox.shrink(),
          (reportType[0] == true) ? SizedBox(height: 10) : SizedBox.shrink(),
          (reportType[0] == true) ? buildServiceTable(pdfData) : SizedBox.shrink(),
          (reportType[0] == true) ? SizedBox(height: 10) : SizedBox.shrink(),
          (reportType[0] == true) ? buildTotalReport(pdfData, 1) : SizedBox.shrink(),
          (reportType[0] == true) ? SizedBox(height: 25) : SizedBox.shrink(),
          
          //WITHDRAW
          (reportType[1] == true) ? buildSubheader('Laporan Pengeluaran') : SizedBox.shrink(),
          (reportType[0] == true) ? SizedBox(height: 10) : SizedBox.shrink(),
          (reportType[1] == true) ? buildWithdrawTable(pdfData) : SizedBox.shrink(),
          (reportType[0] == true) ? SizedBox(height: 10) : SizedBox.shrink(),
          (reportType[1] == true) ? buildTotalReport(pdfData, 2) : SizedBox.shrink(),
          (reportType[1] == true) ? SizedBox(height: 25) : SizedBox.shrink(),

          //NET INCOME
          (reportType[2] == true) ? buildRecapIncome(pdfData) : SizedBox.shrink(),
        ],
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      ),
    );

    String foldername = 'Laporan ${DateFormat('d MMM').format(pdfData.dateData.start)} - ${DateFormat('d MMM').format(pdfData.dateData.end)}.pdf';

    return PdfApi.saveDocument(name: foldername, pdf: pdf);
  }

  //Header, include information of date from
  static Widget buildHeader(PdfData pdfData) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Laporan Outcast Barbershop', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('Tanggal : ${DateFormat('d MMMM').format(pdfData.dateData.start)} - ${DateFormat('d MMMM').format(pdfData.dateData.end)}'),
      ]);

  //Information of services done
  static Widget buildServiceTable(PdfData pdfData) {
    int iteration = 0;
    final headers = [
      'No',
      'Tgl',
      'Kostumer',
      'Barber',
      'Service',
      'Produk Terjual',
      'Total',
    ];

    final dataservices = pdfData.recordServices.map((e) {
      iteration += 1;
      return [
        iteration,
        DateFormat('d MMM').format(e.date),
        e.nameCostumer,
        e.nameBarber,
        e.services
            .map((e) => '${e.name} ${e.amount} x ${CurrencyUtils.currencyIDRwoSymbol(e.price)} \n').toList().join(),
        e.products
            .map((e) => '${e.name} ${e.amount} x ${CurrencyUtils.currencyIDRwoSymbol(e.price)} \n').toList().join(),
        CurrencyUtils.currencyIDR(e.totalprice)
      ];
    }).toList();

    return Table.fromTextArray(
        headers: headers,
        data: dataservices,
        headerStyle: TextStyle(fontWeight: FontWeight.bold),
        headerDecoration: BoxDecoration(color: PdfColors.grey300),
        cellHeight: 20,
        cellAlignments: {
          0: Alignment.center,
          1: Alignment.center,
          2: Alignment.center,
          3: Alignment.center,
          4: Alignment.centerLeft,
          5: Alignment.centerLeft,
          6: Alignment.center,
        },
        columnWidths: {
          0: FixedColumnWidth(30),
          1: FixedColumnWidth(40),
          2: FixedColumnWidth(70),
          3: FixedColumnWidth(55),
          4: FixedColumnWidth(90),
          5: FixedColumnWidth(90),
          6: FixedColumnWidth(70),
        });
  }

  //Information of withdraw
  static Widget buildWithdrawTable(PdfData pdfData) {
    int iteration = 0;
    final headers = [
      'No',
      'Tgl',
      'Barber',
      'Pengeluaran Untuk',
      'List Barang',
      'Harga',
      'Total',
    ];

    final dataservices = pdfData.recordWItdraws.map((e) {
      iteration += 1;
      return [
        iteration,
        DateFormat('d MMM').format(e.date),
        e.nameBarber,
        e.title,
        e.withdraws.map((e) => '${e.name} x ${e.amount} \n').toList().join(),
        e.withdraws.map((e) => '${CurrencyUtils.currencyIDRwoSymbol(e.total)} \n').toList().join(),
        CurrencyUtils.currencyIDR(e.price)
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: dataservices,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 20,
      cellAlignments: {
        0: Alignment.center,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.centerLeft,
        4: Alignment.centerLeft,
        5: Alignment.center,
        6: Alignment.center,
      },
    );
  }

  //Information Total Income from services and outcome from withdraw
  static Widget buildRecapIncome(PdfData pdfData) {
    String earnservice = CurrencyUtils.currencyIDR(pdfData.recordRecap.earnservice);
    String earnwithdraw = CurrencyUtils.currencyIDR(pdfData.recordRecap.earnwithdraw);
    String total = CurrencyUtils.currencyIDR(pdfData.recordRecap.earnservice - pdfData.recordRecap.earnwithdraw);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Laporan Pendapatan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      SizedBox(height: 10),
      Text(
          'Laporan Pendapatan yang didapat dari tanggal ${DateFormat('d MMMM').format(pdfData.dateData.start)} - ${DateFormat('d MMMM').format(pdfData.dateData.end)} :',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
      SizedBox(height: 10),
      Text('Pendapatan dari service dan penjualan  -  pengeluaran', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      SizedBox(height: 5),
      Text('= $earnservice  -  $earnwithdraw', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      SizedBox(height: 5),
      Text('= $total', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    ]);
  }

  //Sub-Header
  static Widget buildSubheader(String title) {
    return Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }

  //Recap total report
  //1 => service
  //2 => withdraws
  static Widget buildTotalReport(PdfData pdfData, int choose) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('Total pada tanggal ${DateFormat('d MMMM').format(pdfData.dateData.start)} - ${DateFormat('d MMMM').format(pdfData.dateData.end)} = ',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
        Text(
            '${CurrencyUtils.currencyIDR((choose == 1) ? pdfData.recordRecap.earnservice : pdfData.recordRecap.earnwithdraw)}',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
