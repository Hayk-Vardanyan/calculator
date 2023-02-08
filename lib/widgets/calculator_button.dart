import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final void Function(String) onTap;
  final String buttonName;
  final Color buttonColor;
  final Color textColor;

  const CalculatorButton({
    Key? key,
    required this.onTap,
    required this.buttonName,
    required this.buttonColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onTap(buttonName),
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          fixedSize: const Size(100, 100),
          shape: const CircleBorder(),
        ),
        child: Text(
          buttonName,
          style: TextStyle(
            color: textColor,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
