import 'package:flutter/material.dart';

import 'package:calculator/widgets/calculator_button.dart';
import 'package:calculator/widgets/screen.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  bool actionButtonActivated = false;
  String lastActivated = '';
  String currentInput = '';
  String first = '';

  void outputNumber(String number) {
    setState(() {
      if (currentInput == '0' && number != '.') currentInput = '';
      if (currentInput.length <= 6) {
        if (actionButtonActivated == false) {
          currentInput += number;
        } else {
          currentInput = '';
          currentInput += number;
          actionButtonActivated = false;
        }
      }
    });
  }

  void deleteInput(_) {
    setState(() {
      currentInput = '';
    });
  }

  void changeMode(String action) {
    lastActivated = action;
    actionButtonActivated = true;
    first = currentInput;
  }

  void changeValue(_) {
    setState(() {
      if (currentInput.contains('.')) {
        double value = double.parse(currentInput);
        value -= value * 2;
        currentInput = value.toString();
      } else {
        int value = int.parse(currentInput);
        value -= value * 2;
        currentInput = value.toString();
      }
    });
  }

  void outputResult(_) {
    late String result;
    if (actionButtonActivated || lastActivated != '') {
      if (lastActivated == '+') {
        if (currentInput.contains('.') || first.contains('.')) {
          result =
              (double.parse(currentInput) + double.parse(first)).toString();
        } else {
          result =
              (int.parse(currentInput) + int.parse(first)).toString();
        }
      } else if (lastActivated == '-') {
        if (currentInput.contains('.') || first.contains('.')) {
          result =
              (double.parse(first) - double.parse(currentInput)).toString();
        } else {
          result =
              (int.parse(first) - int.parse(currentInput)).toString();
        }
      } else if (lastActivated == '/') {
        if (currentInput.contains('.') || first.contains('.')) {
          result =
              (double.parse(first) / double.parse(currentInput)).toString();
        } else {
          result =
              ((int.parse(first) / int.parse(currentInput))).toString();
        }
      } else if (lastActivated == 'x') {
        if (currentInput.contains('.') || first.contains('.')) {
          result =
              (double.parse(currentInput) * double.parse(first)).toString();
        } else {
          result =
              (int.parse(currentInput) * int.parse(first)).toString();
        }
      } else if (lastActivated == '%') {
        if (currentInput.contains('.') || first.contains('.')) {
          result =
              (double.parse(first) * (double.parse(currentInput) / 100))
                  .toString();
        } else {
          result =
              (int.parse(first) * (int.parse(currentInput) / 100)).toString();
        }
      }
      if (result.length > 6) {
        result = result.substring(0, 6);
      }
      if (result.contains('.')) {
        int indexOfDot = result.indexOf('.');
        if (result[indexOfDot + 1] == '0' &&
            (indexOfDot + 1 == result.length - 1)) {
          result = result.substring(0, indexOfDot);
        }
      }
      setState(() {
        currentInput = result;
        actionButtonActivated = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0), // 300
        child: Column(
          children: [
            Screen(currentInput: currentInput),
            Expanded(
              child: Row(
                children: [
                  CalculatorButton(
                    buttonName: 'AC',
                    buttonColor: Colors.grey,
                    textColor: Colors.black,
                    onTap: deleteInput,
                  ),
                  CalculatorButton(
                    buttonName: '+/-',
                    buttonColor: Colors.grey,
                    textColor: Colors.black,
                    onTap: changeValue,
                  ),
                  CalculatorButton(
                    buttonName: '%',
                    buttonColor: Colors.grey,
                    textColor: Colors.black,
                    onTap: changeMode,
                  ),
                  CalculatorButton(
                    buttonName: '/',
                    buttonColor: Colors.amber,
                    textColor: Colors.white,
                    onTap: changeMode,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                children: [
                  CalculatorButton(
                    buttonName: '7',
                    buttonColor: Colors.grey,
                    textColor: Colors.black,
                    onTap: outputNumber,
                  ),
                  CalculatorButton(
                    buttonName: '8',
                    buttonColor: Colors.grey,
                    textColor: Colors.black,
                    onTap: outputNumber,
                  ),
                  CalculatorButton(
                    buttonName: '9',
                    buttonColor: Colors.grey,
                    textColor: Colors.black,
                    onTap: outputNumber,
                  ),
                  CalculatorButton(
                    buttonName: 'x',
                    buttonColor: Colors.amber,
                    textColor: Colors.white,
                    onTap: changeMode,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalculatorButton(
                    buttonName: '4',
                    buttonColor: Colors.grey,
                    textColor: Colors.black,
                    onTap: outputNumber,
                  ),
                  CalculatorButton(
                    buttonName: '5',
                    buttonColor: Colors.grey,
                    textColor: Colors.black,
                    onTap: outputNumber,
                  ),
                  CalculatorButton(
                    buttonName: '6',
                    buttonColor: Colors.grey,
                    textColor: Colors.black,
                    onTap: outputNumber,
                  ),
                  CalculatorButton(
                    buttonName: '-',
                    buttonColor: Colors.amber,
                    textColor: Colors.white,
                    onTap: changeMode,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CalculatorButton(
                    buttonName: '1',
                    buttonColor: Colors.grey,
                    textColor: Colors.black,
                    onTap: outputNumber,
                  ),
                  CalculatorButton(
                    buttonName: '2',
                    buttonColor: Colors.grey,
                    textColor: Colors.black,
                    onTap: outputNumber,
                  ),
                  CalculatorButton(
                    buttonName: '3',
                    buttonColor: Colors.grey,
                    textColor: Colors.black,
                    onTap: outputNumber,
                  ),
                  CalculatorButton(
                    buttonName: '+',
                    buttonColor: Colors.amber,
                    textColor: Colors.white,
                    onTap: changeMode,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        outputNumber('0');
                      },
                      borderRadius: BorderRadius.circular(60),
                      child: Container(
                        height: 140,
                        padding: const EdgeInsets.only(left: 30),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.grey,
                        ),
                        child: const Text(
                          '0',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CalculatorButton(
                    buttonName: '.',
                    buttonColor: Colors.amber,
                    textColor: Colors.white,
                    onTap: outputNumber,
                  ),
                  CalculatorButton(
                    buttonName: '=',
                    buttonColor: Colors.amber,
                    textColor: Colors.white,
                    onTap: outputResult,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
