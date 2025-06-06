import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  String buttonName;
  VoidCallback onPressed;

  DialogButton({super.key, required this.buttonName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      onPressed: onPressed,
      child: Text(
        buttonName,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
