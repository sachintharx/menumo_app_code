import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;

  const MyButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 252, 201, 8),
          borderRadius: BorderRadius.circular(40),
           // Adjust the value for rounded corners
        ),
        child: Center(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AnimatedDefaultTextStyle(
              style: TextStyle(
                color: const Color.fromARGB(255, 49, 49, 49),
                fontWeight: FontWeight.bold,
              ),
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Text(text),
            ),
          ),
        ),
      ),
    );
  }
}
