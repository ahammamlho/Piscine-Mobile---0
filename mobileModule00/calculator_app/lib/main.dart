// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _expressionController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  String _expression = "";
  String _result = "0";

  @override
  void initState() {
    super.initState();
    _expressionController.text = "0";
    _resultController.text = "0";
  }

  void _onButtonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'AC':
          _allClear();
          break;
        case 'C':
          _clear();
          break;
        case '=':
          _calculateResult();
          break;
        case '+':
        case '-':
        case '*':
        case '/':
          _addOperator(buttonText);
          break;
        default:
          _addNumber(buttonText);
      }
      _updateDisplay();
    });
  }

  void _allClear() {
    _expression = "";
    _result = "0";
  }

  void _clear() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      if (_expression.isEmpty) {
        _result = "0";
      }
    }
  }

  void _addNumber(String number) {
    if (_expression == "0" && number != ".") {
      _expression = number;
    } else if (number == ".") {
      if (_expression.isEmpty || _expression == "0") {
        _expression = "0.";
      } else {
        String lastNumber = _getLastNumber();
        if (lastNumber.contains(".")) return;
        _expression += number;
      }
    } else {
      _expression += number;
    }
  }

  void _addOperator(String operator) {
    if (_expression.isEmpty) return;

    if (_isOperator(_expression[_expression.length - 1])) {
      _expression = _expression.substring(0, _expression.length - 1) + operator;
    } else {
      _expression += operator;
    }
  }

  void _calculateResult() {
    if (_expression.isEmpty) return;

    try {
      String expr = _expression;
      if (_isOperator(expr[expr.length - 1])) {
        expr = expr.substring(0, expr.length - 1);
      }

      double result = _evaluateExpression(expr);
      _result = _formatResult(result);
    } catch (e) {
      _result = "Error";
    }
  }

  double _evaluateExpression(String expression) {
    Parser parser = Parser();
    Expression exp = parser.parse(expression);
    ContextModel contextModel = ContextModel();
    return exp.evaluate(EvaluationType.REAL, contextModel);
  }

  String _formatResult(double result) {
    if (result == result.toInt()) {
      return result.toInt().toString();
    } else {
      return result
          .toStringAsFixed(8)
          .replaceAll(RegExp(r'0*$'), '')
          .replaceAll(RegExp(r'\.$'), '');
    }
  }

  String _getLastNumber() {
    String lastNumber = "";
    for (int i = _expression.length - 1; i >= 0; i--) {
      if (_isOperator(_expression[i])) {
        break;
      }
      lastNumber = _expression[i] + lastNumber;
    }
    return lastNumber;
  }

  bool _isOperator(String char) {
    return char == '+' || char == '-' || char == '*' || char == '/';
  }

  void _updateDisplay() {
    _expressionController.text = _expression.isEmpty ? "0" : _expression;
    _resultController.text = _result;
  }

  Widget _buildButton(String text, {Color? color, Color? textColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[300],
            foregroundColor: textColor ?? Colors.black,
            padding: const EdgeInsets.all(16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: isLandscape ? _buildLandscapeLayout() : _buildPortraitLayout(),
    );
  }

  Widget _buildPortraitLayout() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _expressionController,
                readOnly: true,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 24),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Expression',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _resultController,
                readOnly: true,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Result',
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: _buildButtonGrid(),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: TextField(
                    controller: _expressionController,
                    readOnly: true,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expression',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TextField(
                    controller: _resultController,
                    readOnly: true,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Result',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: _buildButtonGrid(),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonGrid() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              _buildButton(
                'AC',
                color: Colors.red[300],
                textColor: Colors.white,
              ),
              _buildButton(
                'C',
                color: Colors.orange[300],
                textColor: Colors.white,
              ),
              _buildButton(
                '/',
                color: Colors.blue[300],
                textColor: Colors.white,
              ),
              _buildButton(
                '*',
                color: Colors.blue[300],
                textColor: Colors.white,
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton(
                '-',
                color: Colors.blue[300],
                textColor: Colors.white,
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton(
                '+',
                color: Colors.blue[300],
                textColor: Colors.white,
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton(
                '=',
                color: Colors.green[400],
                textColor: Colors.white,
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () => _onButtonPressed('0'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      '0',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              _buildButton('.'),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _expressionController.dispose();
    _resultController.dispose();
    super.dispose();
  }
}
