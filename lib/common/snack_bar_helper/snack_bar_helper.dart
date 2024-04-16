import 'package:flutter/material.dart';

void showSnackBarWarning(BuildContext context, String message) {
  showSnackBar(context, message, Colors.orange.shade700, Icons.warning_rounded);
}

void showSnackBarError(BuildContext context, String message) {
  showSnackBar(
      context, message, Colors.red.shade700, Icons.error_outline_outlined);
}

void showSnackBarSuccess(BuildContext context, String message) {
  showSnackBar(context, message, Colors.green.shade700, Icons.check);
}

void showSnackBar(
  BuildContext context,
  String message,
  Color? backgroundColor,
  IconData? prefixIcon,
) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: backgroundColor ?? Colors.grey.shade700,
    content: Row(
      children: [
        Icon(
          prefixIcon,
          color: Colors.white,
        ),
        SizedBox(
          width: 24,
        ),
        Flexible(
          child: Text(
            message,
            maxLines: 4,
            overflow: TextOverflow.clip,
          ),
        )
      ],
    ),
  ));
}
