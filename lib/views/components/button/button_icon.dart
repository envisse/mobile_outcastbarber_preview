part of 'barrel.dart';

// ignore: must_be_immutable
class ButtonIconComponent extends StatelessWidget {
  
  //must fill
  void Function() onPressed;
  bool isOutlined;
  Widget icon;

  ButtonIconComponent(
      {required this.onPressed, required this.icon, required this.isOutlined});

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        child: icon,
        style: OutlinedButton.styleFrom(
          shape: CircleBorder(),
        ),
      );
    }
    return IconButton(onPressed: onPressed, icon: icon);
  }
}
