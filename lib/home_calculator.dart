import 'package:flutter/material.dart';

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String input = "";
  String output = "0";

  void buttonPressed(String text) {
    setState(() {
      if (text == "C") {
        if (input.isNotEmpty) input = input.substring(0, input.length - 1);
      }

      else if (text == "+" || text == "-" || text == "×" || text == "÷") {
        if (input.isNotEmpty && !input.contains(" ")) {
          input += " $text ";
        }
      }

      else if (text == "=") {
        final parts = input.split(" ");
        if (parts.length == 3) {
          double n1 = double.parse(parts[0]);
          String op = parts[1];
          double n2 = double.parse(parts[2]);

          double result = 0;
          if (op == "+") result = n1 + n2;
          if (op == "-") result = n1 - n2;
          if (op == "×") result = n1 * n2;
          if (op == "÷") result = n1 / n2;

          // Round to 4 decimal places if too long, else scientific notation if very big
          if (result.abs() < 1e10) {
            output = result.toStringAsFixed(4); // 4 decimal places
            output = double.parse(output).toString(); // remove trailing zeros
          } else {
            output = result.toStringAsExponential(5); // scientific notation
          }
        }
      }

      else {
        input += text;
      }

      if (input.isEmpty) output = "0";
    });
  }

  Widget buildButton(String text, {Color? color}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(6),
        height: 65,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.white,
            elevation: 1,
          ),
          onPressed: () => buttonPressed(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: color == null ? Colors.black : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              alignment: Alignment.bottomRight,
              child: Text(
                input.isEmpty ? "0" : input,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.black54,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: Column(
                children: [
                  Row(children: [
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("÷", color: Colors.orange),
                  ]),
                  Row(children: [
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("×", color: Colors.orange),
                  ]),
                  Row(children: [
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("-", color: Colors.orange),
                  ]),
                  Row(children: [
                    buildButton("."),
                    buildButton("0"),
                    buildButton("C", color: Colors.red),
                    buildButton("+", color: Colors.orange),
                  ]),
                SizedBox(
                  height: 25,
                ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                    height: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () => buttonPressed("="),
                      child: const Text(
                        "=",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
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
