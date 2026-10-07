import 'package:flutter/material.dart';
import 'package:flutter_countdown_view/flutter_countdown_view.dart';

void main() {
  runApp(const CountdownDemoApp());
}

class CountdownDemoApp extends StatelessWidget {
  const CountdownDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Countdown View',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const CountdownHomePage(),
    );
  }
}

class CountdownHomePage extends StatelessWidget {
  const CountdownHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final targetDate = DateTime.now().add(
      const Duration(days: 7, hours: 12, minutes: 30),
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF141E30),
              Color(0xFF243B55),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.timer_outlined,
                    size: 58,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Countdown View',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Your event starts in',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CountdownView(
                    targetDateTime: targetDate,
                    config: const CountdownConfig(
                      backgroundColor: Color(0xFF202938),
                      textColor: Colors.white,
                      labelColor: Colors.white60,
                      separatorColor: Colors.white,
                      borderRadius: 16,
                      boxWidth: 72,
                      boxHeight: 82,
                      numberFontSize: 28,
                      labelFontSize: 10,
                    ),
                    onComplete: () {
                      debugPrint('Countdown completed');
                    },
                  ),
                  const SizedBox(height: 35),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                    child: const Text(
                      'Real-time countdown • Updates every second',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}