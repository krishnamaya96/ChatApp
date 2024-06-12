
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();

  List<ChatMessage> _messages = [
    ChatMessage(sender: 'Sai', content: 'Hello!'),
    ChatMessage(sender: 'Amalu', content: 'Hi there!'),
  ];

  bool _isEmojiVisible = false;

  void _onEmojiSelected(Emoji emoji) {
    _textController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: _textController.text.length),
      );
  }

  void _onBackspacePressed() {
    _textController
      ..text = _textController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: _textController.text.length),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/ai4.jpg"),
          ),
          
          SizedBox(width: 10,),
          
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name",style: TextStyle(color: Colors.black),),
                Text("Last Seen today at 10.30 AM",style: TextStyle(color: Colors.grey),),
              ],
            ),
          ),
          SizedBox(width: 20,),
          Icon(IconlyLight.video,color: Colors.black,size: 30,),
          SizedBox(width: 10,),
          Icon(IconlyLight.call,color: Colors.black,size: 30,),
          SizedBox(width: 15,)
          
          
        ],


      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_messages[index].content),
                  background: Container(
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      _messages.removeAt(index);
                    });
                  },
                  child: ListTile(
                    title: Text(_messages[index].sender),
                    subtitle: Text(_messages[index].content),
                  ),
                );
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[200],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.emoji_emotions),
                  onPressed: () {
                    setState(() {
                      _isEmojiVisible = !_isEmojiVisible;
                    });
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Message...',
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: _sendMessage,
                  ),
                ),
                Icon(Icons.attach_file,color: Colors.black,),
                SizedBox(width: 5,),
                Icon(IconlyLight.camera,color: Colors.black,),
                SizedBox(width: 5,),
                Icon(Icons.mic,color: Colors.black,),
                SizedBox(width: 5,),
                IconButton(
                  icon: Icon(Icons.send,color: Colors.black,),
                  onPressed: () {
                    _sendMessage(_textController.text);
                  },
                ),

              ],
            ),
          ),
        ),

        Offstage(
          offstage: !_isEmojiVisible,
          child: SizedBox(
            height: 250,
            child: EmojiPicker(
              onEmojiSelected: (category, emoji) {
                _onEmojiSelected(emoji);
              },
              onBackspacePressed: _onBackspacePressed,
              config: Config(
                columns: 7,
                emojiSizeMax: 32.0,
                verticalSpacing: 0,
                horizontalSpacing: 0,
                initCategory: Category.RECENT,
                bgColor: Color(0xFFF2F2F2),
                indicatorColor: Colors.blue,
                iconColor: Colors.grey,
                iconColorSelected: Colors.blue,
                backspaceColor: Colors.blue,
                skinToneDialogBgColor: Colors.white,
                skinToneIndicatorColor: Colors.grey,
                enableSkinTones: true,
                recentTabBehavior: RecentTabBehavior.RECENT,
                recentsLimit: 28,
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _sendMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(sender: 'sender_name', content: text));
    });
    _textController.clear();
  }
}

class ChatMessage {
  final String sender;
  final String content;

  ChatMessage({
    required this.sender,
    required this.content,
  });
}












