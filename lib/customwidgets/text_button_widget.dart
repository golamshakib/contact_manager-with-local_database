import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
        child: TextButton(
          onPressed: onPressed,
          style: const ButtonStyle(
            alignment: Alignment.centerLeft,
            padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.zero),
            minimumSize: WidgetStatePropertyAll<Size>(Size(0, 0)),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            splashFactory: NoSplash.splashFactory,
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }
}
