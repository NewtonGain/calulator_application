// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";

  String result = "0";
  List<String> buttonList = [
    'C',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'AC',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: resultWidget(),
            ),
            Flexible(
              flex: 2,
              child: inputWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget resultWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          alignment: Alignment.centerRight,
          child: Text(
            userInput,
            style: const TextStyle(fontSize: 32),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(22),
          alignment: Alignment.centerRight,
          child: Text(
            result,
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget inputWidget() {
    return GridView.builder(
      itemCount: buttonList.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return button(buttonList[index]);
      },
    );
  }

  Widget button(String text) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            handleButtonPress(text);
          });
        },
        color: getColor(text),
        textColor: Colors.white,
        shape: const CircleBorder(),
        child: Text(
          text,
          style: const TextStyle(fontSize: 25),
        ),
      ),
    );
  }

  handleButtonPress(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }
    if (text == "C") {
      userInput = userInput.substring(0, userInput.length - 1);
      return;
    }
    if (text == "=") {
      result = calculate();
      return;
    }
    if (text == "=") {
      result = calculate();
      if (result.endsWith(".0")) result = result.replaceAll('.0', "");
    }
    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evatuation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evatuation.toString();
    } catch (e) {
      return calculate();
    }
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "=") {
      return Colors.orangeAccent;
    }
    if (text == "C" || text == "AC") {
      return Colors.blueGrey;
    }
    if (text == "(" || text == ")") {
      return Colors.red;
    }
    return Colors.lightBlue;
  }
}
