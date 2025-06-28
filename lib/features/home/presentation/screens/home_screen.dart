import 'package:flutter/material.dart';
import 'package:get_task/commons/widgets/KText.dart';
import 'package:get_task/commons/widgets/KTextField.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class HomeScreen extends StatefulWidget {
  final String? userName;

  const HomeScreen({super.key, this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WebSocketChannel channel;

  final List<Map<String, String>> messages = [];

  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    channel = WebSocketChannel.connect(Uri.parse("ws://192.168.1.7:8000/ws"));

    // Listening to changes in the connections
    channel.stream.listen((data) {
      final parts = data.split(":");
      if (parts.length >= 2) {
        final sender = parts[0].trim();
        final msg = parts.sublist(1).join(":").trim();

        setState(() {
          messages.add({"sender": sender, "message": msg});
        });
        print(" 🌎📨 Message form socket: $msg");
      }
    });

    super.initState();
  }

  // Send Message
  void sendMessage() {
    final message = messageController.text.trim();
    if (message.isNotEmpty) {
      final fullMessage = "${widget.userName}: $message";

      print("Message: ✅📨 $fullMessage");
      channel.sink.add(fullMessage);
      messageController.clear();
    }
  }

  @override
  void dispose() {
    channel.sink.close(status.normalClosure);
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: KText(text: "Chat as ${widget.userName}")),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {},
              ),
            ),

            KTextField(
              controller: messageController,
              onFieldSubmitted: (p0) => sendMessage(),
              hintText: "Enter message",
              prefixIcon: Icons.message,
            ),
          ],
        ),
      ),
    );
  }
}
