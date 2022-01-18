import 'package:flutter/material.dart';

class TextFieldComponent extends StatelessWidget {
  //must fill
  late final TextEditingController textEditingController;

  //optional
  final bool? obsecuretext;
  final String? labelText;
  final Widget? prefixIcon;
  final TextInputType? keyboardtype;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validator;

  TextFieldComponent({required this.textEditingController,this.obsecuretext,this.labelText,this.prefixIcon,this.keyboardtype,this.onEditingComplete,this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obsecuretext ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: prefixIcon,
      ),
      keyboardType: keyboardtype, 
      onEditingComplete: onEditingComplete,
      validator: validator,
    );
  }
}
