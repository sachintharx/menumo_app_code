import 'package:menumo/components/my_text_field.dart';
import 'package:menumo/services/menu/menu_service.dart';
//import 'package:menumo/services/menu/menu_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class menuPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const menuPage({
    Key? key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  }) : super(key: key);

  @override
  State<menuPage> createState() => _menuPageState();
}

class _menuPageState extends State<menuPage> {
  final TextEditingController _messageController = TextEditingController();
  final menuService _menuService = menuService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _menuService.sendMessage(
          widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Assuming this is inside a stateful widget class
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _menuService.getMessages(
        widget.receiverUserID,
        _firebaseAuth.currentUser!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        //final List<QueryDocumentSnapshot> messages = snapshot.data!.docs as List<QueryDocumentSnapshot>;
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Align the messages to the right if the sender is the current user, otherwise to the left
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data[
              'senderEmail']), // Use a default value or handle the case where 'senderEmail' is null

          const SizedBox(
              height: 4), // Add some spacing between sender and message
          Text(data[
              'message']), // Use a default value or handle the case where 'message' is null
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        // Textfield
        Expanded(
          child: MyTextField(
            controller: _messageController,
            hintText: 'Enter message',
            obscureText: false,
          ), // MyTextField
        ), // Expanded

        // Send button
        IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_upward,
              size: 40,
            ))
      ], // Row children
    ); // Row
  }
}
