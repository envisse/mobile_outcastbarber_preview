part of 'barrel.dart';

// ignore: must_be_immutable
class ButtonContainedComponent extends StatelessWidget {
  //Must fill
  void Function() onPressed;
  String text;

  //optional
  bool isIcon;
  Widget? icon;

  ButtonContainedComponent(
      {required this.onPressed,required this.text,required this.isIcon,this.icon});
      
  @override
  Widget build(BuildContext context) {
    if (isIcon) {
      return ElevatedButton.icon(
          onPressed: onPressed, icon: icon!, label: Text(text));
    }
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
