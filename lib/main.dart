import 'package:flutter/material.dart';
import 'package:chat_gpt_app/model.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() {
  runApp(ChatGptApp());
}

class ChatGptApp extends StatefulWidget {
  ChatGptApp({super.key});

  @override
  State<ChatGptApp> createState() => _ChatGptAppState();
}

class _ChatGptAppState extends State<ChatGptApp> {
  ChatRoom _room = ChatRoom(chats: [], createdAt: DateTime.now());

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _canSendMessage = false;

  // Gemini 초기화
  @override
  void initState() {
    super.initState();
    Gemini.init(apiKey: YOUR_API_KEY);
  }

  // 메모리 누수를 막기 위해 화면이 더 이상 존재하지 않을 때 해제해주는 메소드
  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "GPT",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.only(bottom: 100),
              children: [
                for (var chat in _room.chats)
                  if (chat.isMe)
                    _buldMyChatBubble(chat)
                  else
                    _buldGPTChatBubble(chat)
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  padding: EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: _buildTextField(),
                )),
            if (_room.chats.isEmpty)
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/logo.png",
                    width: 40,
                  ))
          ],
        ),
      ),
    );
  }

  Align _buldMyChatBubble(ChatMessage chat) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          constraints: BoxConstraints(maxWidth: 260),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          margin: EdgeInsets.only(left: 16, right: 10, bottom: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey[100],
          ),
          child: Text(
            chat.text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          )),
    );
  }

  Align _buldGPTChatBubble(ChatMessage chat) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image.asset(
                  "assets/logo.png",
                  width: 25,
                ),
                margin: EdgeInsets.only(right: 10, left: 20),
              ),
              Container(
                  constraints: BoxConstraints(maxWidth: 260),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  margin: EdgeInsets.only(left: 0, right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(0, 245, 245, 245),
                  ),
                  child: Text(
                    chat.text,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  )),
            ],
          ),
        ));
  }

  Widget _buildTextField() {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      onSubmitted: (_) {
        _sendMessage();
      },
      onChanged: (value) {
        setState(() {
          _canSendMessage = value.isNotEmpty;
        });
      },
      decoration: InputDecoration(
        hintText: "메시지 입력",
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          vertical: 15.0,
        ),
        suffixIcon: IconButton(
          icon: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _canSendMessage
                    ? Colors.black
                    : const Color.fromARGB(106, 158, 158, 158),
              ),
              child: Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
              )),
          onPressed: () {
            _sendMessage();
          },
        ),
      ),
      style: TextStyle(
        fontSize: 14,
      ),
    );
  }

  void _sendMessage() {
    _focusNode.unfocus();

    final ChatMessage chat = ChatMessage(
      isMe: true,
      text: _controller.text,
      sentAt: DateTime.now(),
    );

    setState(() {
      _room.chats.add(chat);
      _canSendMessage = false;
    });

    String question = _controller.text;

    // 사용자가 채팅창에 입력한 값을 Gemini에 전달
    Gemini.instance.streamGenerateContent(question).listen((e) {
      setState(() {
        _room.chats.last.text += e.output ?? "";
      });
    });
    // 생성형 AI 말풍선 노출 ( 내용은 비어져 있음 )
    _room.chats.add(
      ChatMessage(isMe: false, text: "", sentAt: DateTime.now()),
    );

    // Gemini로부터 응답값을 계속 받아볼 수 있도록 함
    // 응답값을 AI 말충선에 추가

    _controller.clear();
  }
}
