part of 'barrel.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextComponent(text: 'Page not found', textStyling: TextStyling.body),
      ),
    );
  }
}
