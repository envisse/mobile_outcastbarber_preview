import 'package:flutter/material.dart';

class DialogsComponents {
  Future<void> confirmation({required BuildContext context,required void Function() function}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure ?'),
          actions: [
            TextButton(
                onPressed: function,
                child: Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No')),
          ],
        );
      },
    );
  }
}
