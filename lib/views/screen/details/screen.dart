part of 'barrel.dart';

enum Screen { DetailsWithdraw, DetailsService }

class DetailsScreen extends StatelessWidget {
  final Screen screen;
  final RecordServices? recordServices;
  final RecordWithdraws? recordWithdraws;
  DetailsScreen({required this.screen, this.recordServices, this.recordWithdraws});
  @override
  Widget build(BuildContext context) {
    if (screen == Screen.DetailsService) {
      return DetailsServicePage(recordServices: recordServices!,);
    }
    return DetailsWithdrawPage(recordWithdraws: recordWithdraws!,);
  }
}
