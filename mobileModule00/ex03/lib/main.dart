import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _expressionController.text = "0";
    _resultController.text = "0";
  }

  void _onButtonPressed(String buttonText) {
    print(buttonText);
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
