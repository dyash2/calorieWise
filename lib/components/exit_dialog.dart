import 'package:flutter/material.dart';

class ExitConfirmationDialog extends StatelessWidget {
  const ExitConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('Do you want to quit the app?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // User pressed 'No'
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true); // User pressed 'Yes'
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
