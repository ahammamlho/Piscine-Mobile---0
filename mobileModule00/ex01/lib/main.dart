import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise 01',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isHelloWorld = false;
  final String _initialText = "A simple text";

  void _toggleText() {
    setState(() {
      _isHelloWorld = !_isHelloWorld;
    });
    print("Button pressed");
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isHelloWorld ? "Hello World!" : _initialText,

              style: TextStyle(
                fontSize: isTablet ? 32 : 24,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleText,
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: isTablet ? 18 : 16),
              ),
              child: const Text("Press me"),
            ),
          ],
        ),
      ),
    );
  }
}
