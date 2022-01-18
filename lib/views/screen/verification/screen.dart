part of 'barrel.dart';

class VerificationScreen extends StatelessWidget {
  final String setPin;
  VerificationScreen({required this.setPin});
  @override
  Widget build(BuildContext context) {
    return VerificationPage(setPin: setPin,);
  }
}
