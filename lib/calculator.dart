import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";

  final List<String> buttonsList = [
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
    '-',
    '1',
    '2',
    '3',
    '+',
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
              child: resultWidget(),
              flex: 1,
            ),
            Flexible(
              child: buttonsWidget(),
              flex: 2,
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
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(20),
          child: Text(
            userInput,
            style: const TextStyle(fontSize: 32),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              result,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget buttonsWidget() {
    return GridView.builder(
        itemCount: buttonsList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (BuildContext context,int index){
          return button(buttonsList[index]);
        }
    );
  }

  Widget button(String text){
    return Container(
      margin: const EdgeInsets.all(8),
      child: MaterialButton(
        onPressed: (){
          setState(() {
            handleButtonTap(text);
          });
        },
        color: getColor(text),
        textColor: Colors.white,
        child: Text(
          text,
          style: const TextStyle(fontSize: 25),
        ),
        shape: const CircleBorder(),
      ),
    );
  }
  handleButtonTap(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }
    if (text == "=") {
      result = calculate();
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
      return;
    }

    if (text == "C") {
      userInput = userInput.substring(0, userInput.length - 1);
      return;
    }
    userInput = userInput + text;
  }

  calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Err";
    }
  }

  getColor(String text){
    if (text == "/" || text == "*" || text == "+" || text == "-"|| text == "=") {
      return Colors.amber[700];
    }
    if (text == "C" || text == "AC") {
      return Colors.red;
    }
    if (text == "(" || text == ")") {
      return Colors.grey[850];
    }
    return Colors.grey[850];
  }
}
