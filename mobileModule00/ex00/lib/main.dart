import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ex00 - Basic Display',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BasicDisplayPage(),
    );
  }
}

class BasicDisplayPage extends StatelessWidget {
  const BasicDisplayPage({super.key});

  void _onButtonPressed() {
    print('Button pressed');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'A simple text',
                style: TextStyle(
                  fontSize: isTablet ? 32 : 24,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: isTablet ? 30 : 20),
              ElevatedButton(
                onPressed: _onButtonPressed,
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: isTablet ? 18 : 16),
                ),
                child: const Text('Click me'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
