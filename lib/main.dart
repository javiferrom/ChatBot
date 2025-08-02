import 'package:chatbot/screens/chat_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ElCunaditoApp());
}

class ElCunaditoApp extends StatelessWidget {
  const ElCunaditoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'El Cuñadito',
      theme: ThemeData(
        primaryColor: Color(0xFF075E54),
        scaffoldBackgroundColor: Color(0xFFECE5DD),
        fontFamily: 'Roboto',
      ),
      home: ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
