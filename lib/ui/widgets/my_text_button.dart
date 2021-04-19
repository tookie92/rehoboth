import 'package:amen/ui/widgets/my_widgets.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final Function()? onPressed;
  final String? label;
  final Color? colorText;
  final Color? background;

  MyTextButton(
      {required this.onPressed,
      required this.label,
      this.colorText,
      this.background});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          primary: colorText,
          backgroundColor: background,
          shadowColor: Colors.amber,
          elevation: 1.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
        child: MyText(
          label: label,
        ),
      ),
    );
  }
}
