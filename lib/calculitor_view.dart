import 'package:calulator/cubit.dart';
import 'package:calulator/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    String equation = "0";
    String result = "0";
    String expression = "";
    double equationFontSize = 38.0;
    double resultFontSize = 48.0;
    buttonPressed(String buttonText) {
      setState(() {
        if (buttonText == "C") {
          equation = "0";
          result = "0";
          equationFontSize = 38.0;
          resultFontSize = 48.0;
        } else if (buttonText == "⌫") {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          equation = equation.substring(0, equation.length - 1);
          if (equation == "") {
            equation = "0";
          }
        } else if (buttonText == "=") {
          equationFontSize = 38.0;
          resultFontSize = 48.0;
          expression = equation;
          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');
          try {
            Parser p = new Parser();
            Expression exp = p.parse(expression);
            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } catch (e) {
            result = "Error";
          }
        } else {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          if (equation == "0") {
            equation = buttonText;
          } else {
            equation = equation + buttonText;
          }
        }
      });
    }

    Widget buildButton(
        String buttonText, double buttonHeight, Color buttonColor) {
      return Container(
          height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
          color: buttonColor,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.all(16.0),
                side: const BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.white,
                  width: 1,
                )),
            child: Text(
              buttonText,
              style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
            onPressed: () => buttonPressed(buttonText),
          ));
    }

    return BlocProvider(
      create: (BuildContext context) => CalculatorCubit(),
      child: BlocConsumer<CalculatorCubit, CalculatorStates>(
        listener: (BuildContext context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Calculator"),
            ),
            body: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text(
                    equation,
                    style: const TextStyle(fontSize: 38.0),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text(
                    result,
                    style: const TextStyle(fontSize: 48.0),
                  ),
                ),
                const Expanded(
                  child: Divider(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Table(
                        children: <TableRow>[
                          TableRow(children: <Widget>[
                            buildButton("C", 1, Colors.redAccent),
                            buildButton("⌫", 1, Colors.blue),
                            buildButton("÷", 1, Colors.blue),
                          ]),
                          TableRow(children: <Widget>[
                            buildButton("7", 1, Colors.black54),
                            buildButton("8", 1, Colors.black54),
                            buildButton("9", 1, Colors.black54),
                          ]),
                          TableRow(children: <Widget>[
                            buildButton("4", 1, Colors.black54),
                            buildButton("5", 1, Colors.black54),
                            buildButton("6", 1, Colors.black54),
                          ]),
                          TableRow(children: <Widget>[
                            buildButton("1", 1, Colors.black54),
                            buildButton("2", 1, Colors.black54),
                            buildButton("3", 1, Colors.black54),
                          ]),
                          TableRow(children: <Widget>[
                            buildButton("0", 1, Colors.black54),
                            buildButton(".", 1, Colors.black54),
                            buildButton("00", 1, Colors.black54),
                          ]),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Table(children: [
                        TableRow(children: <Widget>[
                          buildButton("×", 1, Colors.blue),
                        ]),
                        TableRow(children: <Widget>[
                          buildButton("+", 1, Colors.blue),
                        ]),
                        TableRow(children: <Widget>[
                          buildButton("-", 1, Colors.blue),
                        ]),
                        TableRow(children: <Widget>[
                          buildButton("=", 2, Colors.redAccent),
                        ]),
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
