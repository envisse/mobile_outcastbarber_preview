import 'package:flutter/material.dart';
import 'package:mobile_outcastbarber/views/shared/dimens.dart';

class BottomModalComponent {
  Future modal({required BuildContext context, required Widget child}) async{    
     return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: Dimens.horizontalMargin,
              vertical: Dimens.verticalMargin),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: child
        );
      },
    );
  }
}
