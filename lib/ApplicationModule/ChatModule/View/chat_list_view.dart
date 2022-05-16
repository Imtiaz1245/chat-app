import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutter/ApplicationModule/ChatModule/usermodel.dart';
import 'package:flutter/material.dart';

class ChatListView extends StatefulWidget {
  final chat;

  const ChatListView({Key? key, this.chat}) : super(key: key);

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  var allChats;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: allChats,
        builder: (BuildContext context, snapshot) {
          List<UserModel>chatList = <UserModel>[];
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(
              color: Colors.red, backgroundColor: Colors.blue,),);
          }
          chatList = UserModel.JsonToListView(snapshot.data!.docs);

          return
            ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: chatList[index].isme==false
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [SizedBox(
                          width: 200,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xBCF6F0F0),
                                borderRadius: BorderRadius.circular(10.0),

                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${chatList[index].message}"),
                              )))
                      ],
                    ),
                  ),
                );
              },
            );
        }

    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getchats();
  }

  void getchats() async {
    allChats = await FirebaseFirestore.instance.collection("Users")
        .doc("${FirebaseAuth.instance.currentUser!.email.toString().trim()}")
        .collection("MyUser")
        .doc(
        "${widget.chat}")
        .collection("Messages").snapshots();
  }
}
