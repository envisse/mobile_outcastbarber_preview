import 'package:flutter/material.dart';
import 'package:mobile_outcastbarber/views/shared/colors.dart';

enum SnackbarStatus { success, error, warning }

class SnackBarComponent {
  //call this function
  static void snackbar(BuildContext context, SnackbarStatus snackbarStatus, String? message) {
    //define snackbar
    var snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: (snackbarStatus == SnackbarStatus.success)
            ? [Text(message ?? 'Success'), Icon(Icons.check,color: Colors.white,)]
              : (snackbarStatus == SnackbarStatus.warning) 
                ? [Text(message ?? 'Warning',style: TextStyle(color: Colors.black),), Icon(Icons.error_outline,color: Colors.black,)]:
                  [Text(message ?? 'Error',style: TextStyle(color: Colors.white),), Icon(Icons.close,color: Colors.black,)],
      ),
      //define background color
      backgroundColor: (snackbarStatus == SnackbarStatus.success) 
                        ? ColorsPicker.SecondaryColor 
                          : (snackbarStatus == SnackbarStatus.warning) 
                          ? ColorsPicker.WarningColor 
                            :ColorsPicker.ErrorColor,
      //setting duration (0.8 sec)                      
      duration: Duration(milliseconds: 800),
    );

    //show snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}