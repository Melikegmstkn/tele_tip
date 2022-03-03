import 'package:flutter/material.dart';

enum MessageType { sender, receiver }

class ChatDetailPage extends StatefulWidget {
  final String title;
  const ChatDetailPage({Key? key, required this.title}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _messageController = TextEditingController();
    var color = const Color(0xE12E183B);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          title: Text(widget.title),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.78,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                height: 80,
                width: double.infinity,
                color: color.withAlpha(50),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.all(8.0),
                        elevation: 5.0,
                        child: TextField(
                          maxLines: null,
                          controller: _messageController,
                          decoration: InputDecoration(
                              hintText: "mesaj gönderin...",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.only(right: 15, bottom: 15),
                child: FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  backgroundColor: color,
                  elevation: 0,
                ),
              ),
            ),
          ],
        )); //Scaffold
  }

  void showModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            color: const Color(0xff737373),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      height: 4,
                      width: 50,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        });
  }
}
