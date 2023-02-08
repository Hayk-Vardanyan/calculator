import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final String currentInput;
  const Screen({Key? key, required this.currentInput}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(0, 70, 50, 0),
          child: Text(
            currentInput,
            textAlign: TextAlign.left,
            style: const TextStyle(color: Colors.white, fontSize: 80),
          ),
        ),
      ],
    );
  }
}
