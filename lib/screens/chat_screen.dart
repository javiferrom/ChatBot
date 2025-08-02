import 'dart:async';
import 'package:flutter/material.dart';
import '../models/cunadito_brain.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  bool _isOnline = true; // 1. Nueva variable
  Timer? _onlineTimer;   // 1. Nueva variable

  void _resetOnlineTimer() {
    _onlineTimer?.cancel();
    setState(() {
      _isOnline = true;
    });
    _onlineTimer = Timer(Duration(seconds: 10), () {
      setState(() {
        _isOnline = false;
      });
    });
  }

  void _sendMessage() {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'Tú', 'text': input});
      _messages.add({'sender': 'El Cuñadito', 'text': '...'});
      _isTyping = true;
      _isOnline = true;
    });

    _controller.clear();

    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _messages.removeLast();
        _messages.add({'sender': 'El Cuñadito', 'text': CunaditoBrain.responder(input)});
        _isTyping = false;
      });
      Future.delayed(Duration(milliseconds: 100), () {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
      _resetOnlineTimer(); // <-- Ahora el temporizador inicia después de la respuesta del bot
    });
  }

  @override
  void dispose() {
    _onlineTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80, // Ajusta la altura de la barra para acomodar el avatar grande
        title: Row(
          children: [
            CircleAvatar(
              radius: 30, // Más grande
              backgroundImage: AssetImage('assets/images/bot.png'),
              backgroundColor: Colors.white24,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('El Cuñadito', style: TextStyle(color: Colors.white, fontSize: 20)),
                  if (_isTyping || _isOnline)
                    Text(
                      _isTyping ? 'Escribiendo...' : 'En línea',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,

                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(255, 14, 41, 38),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['sender'] == 'Tú';

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                      decoration: BoxDecoration(
                        color: isUser ? Color(0xFFDCF8C6) : Color(0xFFEDEDED),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(isUser ? 16 : 0),
                          bottomRight: Radius.circular(isUser ? 0 : 16),
                        ),
                      ),
                      child: Text(
                        msg['text'] ?? '',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Mensaje',
                        border: InputBorder.none,
                      ),
                      onChanged: (_) {
                        _resetOnlineTimer(); // 2. Reinicia el temporizador al escribir
                      },
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
