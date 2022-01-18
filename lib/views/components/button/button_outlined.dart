part of 'barrel.dart';

// ignore: must_be_immutable
class ButtonOutlinedComponent extends StatelessWidget {
  //Must fill
  void Function() onPressed;
  String text;

  //optional
  bool isIcon;
  Widget? icon;

  ButtonOutlinedComponent({required this.onPressed, required this.text,required this.isIcon, this.icon});

  @override
  Widget build(BuildContext context) {
    if(isIcon){
      return OutlinedButton.icon(onPressed: onPressed, icon: icon!, label: Text(text));
    }

    return OutlinedButton(onPressed: onPressed, child: Text(text));
  }
}