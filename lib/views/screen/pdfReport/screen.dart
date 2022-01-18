part of 'barrel.dart';

class PdfReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PdfexportCubit(),
      child: PdfExportPage(),
    );
  }
}
