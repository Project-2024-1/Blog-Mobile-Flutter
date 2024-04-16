import 'dart:ui';
import 'package:flutter/material.dart';

class MessageNotification extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onSwipeUp;
  final String title;
  final String message;

  const MessageNotification(
      {Key? key,
      this.onTap,
      this.onSwipeUp,
      required this.message,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: root(context),
    );
  }

  Widget row(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Color(0xff51595C), fontWeight: FontWeight.bold)),
              SizedBox(
                height: 6,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                child: Text(message, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: Color(0xff51595C), fontSize: 14,)),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget root(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onPanUpdate: (details) {
        // Swiping in right direction.
        if (details.delta.dy < 0) {
          // onSwipeUp();
          if (onSwipeUp != null) onSwipeUp!();
        }
      },
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), //color of shadow
                    spreadRadius: 5, //spread radius
                    blurRadius: 7, // blur radius
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: row(context),
            ),
          ),
        ),
      ),
    ));
  }
}
