import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduationnn/config/dimens.dart';
import 'package:graduationnn/config/palette.dart';
import 'package:graduationnn/services/database.dart';
import '../../../helper/date_time.dart';

class ChatDoctorScreen extends StatefulWidget {
  User? user;
  String? patient;
  ChatDoctorScreen({super.key, this.user, this.patient});

  @override
  State<ChatDoctorScreen> createState() => _ChatDoctorScreenState();
}

class _ChatDoctorScreenState extends State<ChatDoctorScreen> {
  late User _currentUser;
  final fireStore = FirebaseFirestore.instance;
  DatabaseMethods databaseMethods = DatabaseMethods();
  final String collectionChat = 'chats';
  TextEditingController msgController = TextEditingController();

  Future<void> sendMessage() async {
    String messageText = msgController.text.trim();
    if (messageText.isNotEmpty) {
      FirebaseFirestore.instance
          .collection(collectionChat)
          .doc(widget.patient)
          .collection('messages')
          .add({
        'senderID': _currentUser.displayName,
        'msg': messageText,
        'time': DateTime.now(),

      });
      msgController.clear();
    }
    // fireStore.collection(collectionChat).add({
    //   'msg': msgController.text,
    //   'senderID': _currentUser.displayName,
    //   'time': DateTime.now(),
    // });
    // msgController.clear();
  }

  @override
  void initState() {
    _currentUser = widget.user!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.colorPrimary600,
        title: Text('${widget.patient}'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStore
            .collection(collectionChat)
            .doc(widget.patient)
            .collection('messages')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? chatBody(snapshot.data)
              : snapshot.hasError
              ? Text('Error')
              : CircularProgressIndicator();
        },
      ),
    );
  }
  Widget chatBody(dynamic data) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            child: ListView.builder(
                itemCount: data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Align(
                    alignment:
                    _currentUser.displayName == data.docs[index]['senderID']
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: _currentUser.displayName ==
                              data.docs[index]['senderID']
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Bubble(
                              color: Palette.colorPrimary600,
                              nipWidth: 5,
                              elevation: 4,
                              padding: BubbleEdges.all(10),
                              nip: _currentUser.displayName ==
                                  data.docs[index]['senderID']
                                  ? BubbleNip.rightBottom
                                  : BubbleNip.leftBottom,
                              child: Text(
                                data.docs[index]['msg'] ?? '',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              formattedDate(data.docs[index]['time']),
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        )),
                  );
                }),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Palette.colorPrimary600,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabled: true,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            )
                        ),

                      ),
                      controller: msgController,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        sendMessage();
                      },
                      icon: Icon(
                        Icons.send,
                        color: Palette.colorPrimary600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
