import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  bool actionButtonActivated = false;
  String lastActivated = '';
  Map<String, Function> functions = {};
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
    if (actionButtonActivated || lastActivated != '') {
      if (lastActivated == '+') {
        setState(() {
          if (currentInput.contains('.') || first.contains('.')) {
            currentInput =
                (double.parse(currentInput) + double.parse(first)).toString();
          } else {
            currentInput =
                (int.parse(currentInput) + int.parse(first)).toString();
          }
          if (currentInput.length > 6) {
            currentInput = currentInput.substring(0, 6);
          }
          actionButtonActivated = false;
        });
      } else if (lastActivated == '-') {
        setState(() {
          if (currentInput.contains('.') || first.contains('.')) {
            currentInput =
                (double.parse(first) - double.parse(currentInput)).toString();
          } else {
            currentInput =
                (int.parse(first) - int.parse(currentInput)).toString();
          }
          if (currentInput.length > 6) {
            currentInput = currentInput.substring(0, 6);
          }
          actionButtonActivated = false;
        });
      } else if (lastActivated == '/') {
        setState(() {
          if (currentInput.contains('.') || first.contains('.')) {
            currentInput =
                (double.parse(first) / double.parse(currentInput)).toString();
          } else {
            bool flag = false;
            currentInput =
                ((int.parse(first) / int.parse(currentInput))).toString();
            int indexOfDot = currentInput.indexOf('.');
            for (int i = indexOfDot + 1; i < currentInput.length; ++i) {
              if (currentInput[i] != '0') {
                flag = true;
              }
            }
            if (!flag) {
              currentInput =
                  currentInput.substring(0, currentInput.indexOf('.'));
            }
          }
          if (currentInput.length > 6) {
            currentInput = currentInput.substring(0, 6);
          }
          actionButtonActivated = false;
        });
      } else if (lastActivated == 'x') {
        setState(() {
          if (currentInput.contains('.') || first.contains('.')) {
            currentInput =
                (double.parse(currentInput) * double.parse(first)).toString();
          } else {
            currentInput =
                (int.parse(currentInput) * int.parse(first)).toString();
          }
          if (currentInput.length > 6) {
            currentInput = currentInput.substring(0, 6);
          }
          actionButtonActivated = false;
        });
      } //
      else if (lastActivated == '%') {
        setState(() {
          if (currentInput.contains('.') || first.contains('.')) {
            currentInput =
                (double.parse(first) * (double.parse(currentInput) / 100)).toString();
          } else {
            currentInput =
                (int.parse(first) * (int.parse(currentInput) / 100)).toString();
            /////
            bool flag = false;
            int indexOfDot = currentInput.indexOf('.');
            for (int i = indexOfDot + 1; i < currentInput.length; ++i) {
              if (currentInput[i] != '0') {
                flag = true;
              }
            }
            if (!flag) {
              currentInput =
                  currentInput.substring(0, currentInput.indexOf('.'));
            }
            /////
          }
          if (currentInput.length > 6) {
            currentInput = currentInput.substring(0, 6);
          }
          actionButtonActivated = false;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i <= 9; ++i) {
      functions[i.toString()] = outputNumber;
    }
    functions['.'] = outputNumber;
    functions['AC'] = deleteInput;
    functions['+'] = changeMode;
    functions['-'] = changeMode;
    functions['/'] = changeMode;
    functions['x'] = changeMode;
    functions['%'] = changeMode;
    functions['='] = outputResult;
    functions['+/-'] = changeValue;
  }

  Widget buildCalcButton(
      String buttonName, Color buttonColor, Color textColor) {
    // return Expanded(
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          Function curFunction = functions[buttonName]!;
          // print(curFunction.toString());
          curFunction(buttonName);
        },
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
    // );
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
              Row(
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
              ),
              Expanded(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildCalcButton('AC', Colors.grey, Colors.black),
                    buildCalcButton('+/-', Colors.grey, Colors.black),
                    buildCalcButton('%', Colors.grey, Colors.black),
                    buildCalcButton('/', Colors.amber, Colors.white),
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
                    buildCalcButton('7', Colors.grey, Colors.black),
                    buildCalcButton('8', Colors.grey, Colors.black),
                    buildCalcButton('9', Colors.grey, Colors.black),
                    buildCalcButton('x', Colors.amber, Colors.white),
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
                    buildCalcButton('4', Colors.grey, Colors.black),
                    buildCalcButton('5', Colors.grey, Colors.black),
                    buildCalcButton('6', Colors.grey, Colors.black),
                    buildCalcButton('-', Colors.amber, Colors.white),
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
                    buildCalcButton('1', Colors.grey, Colors.black),
                    buildCalcButton('2', Colors.grey, Colors.black),
                    buildCalcButton('3', Colors.grey, Colors.black),
                    buildCalcButton('+', Colors.amber, Colors.white),
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
                    ElevatedButton(
                      onPressed: () {
                        outputNumber('0');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(0, 1, 1, 1),
                        primary: Colors.grey,
                        fixedSize: const Size(140, 140),
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        '0             ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    buildCalcButton('.', Colors.amber, Colors.white),
                    buildCalcButton('=', Colors.amber, Colors.white),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}