import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutter/ApplicationModule/ChatModule/View/chat_list_view.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/app_colors.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_form_field.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_view.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/height_width.dart';
import 'package:flutter/material.dart';

class ChatViewController extends StatefulWidget {
  final useremail,userName;

  const ChatViewController({Key? key, this.useremail, this.userName}) : super(key: key);

  @override
  State<ChatViewController> createState() => _ChatViewControllerState();
}

class _ChatViewControllerState extends State<ChatViewController> {
  TextEditingController chatController = TextEditingController();
  bool onchange = false;
  List chat = [
    "Imtiaz fdg dkkh dsjjhg sdgsd sdkgbb dgajg sdgbasg sd gjkasg kjdg dfjdfgdf dfkgjbdf bd",
    "jghdfgdf fdgkdfjgdfg fdgkbdf fdk",
    " dfkhjdfgbdfgbd",
    "gkldjfgld  sdgjj ddjsdsg dfjdfgdf dfkgjbdf bd",
    "jghdfgdf fdgkdfjgdfg fdgkbdf fdk",
    " dfkhjdfgbdfgbd",
    "gkldjfgld fdgkjdg dfjdfgdf dfkgjbdf bd",
    "sgsdklg sdgjs sdjkbgs bhu jj k k  fdgkdfjgdfg fdgkbdf fdk",
    " dfkhjdfgbdfgbd",
    "gkldjfgld fdgkjdg dfjdfgdf dfkgjbdf bd",
    "jghdfgdf  fdgkbdf fdk",
    " dfkhjdfgbdfgbd",
    "gkldjfgld fdgkjdg dfjdfgdf dfkgjbdf bd",
    "jghdfgdf  n hg dsf jdj djf djfjfgfgjf fdkjghdfgdf  n hg dsf jdj djf djfjfgfgjf fdk",
    " dfkhjdfgbdfgbd",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.defaultcolor,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_sharp,
                color: AppColor.white,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/imtiaz.jpg"),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            DefaultTextView(
              text: "${widget.userName}",
              textcolor: AppColor.white,
              fontSize: 20.0,
              fontweight: FontWeight.bold,
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.videocam_rounded,
                color: AppColor.white,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.call,
                color: AppColor.white,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: AppColor.white,
              )),
        ],
      ),
      body: SafeArea(
          child: SizedBox(
        height: CustomHeight(context),
        width: CustomWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ChatListView(
              chat: widget.useremail,
            )),
            Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: SizedBox(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DefaultTextFormFieldView(
                      height: 50.0,
                      hint: "Message",
                      controller: chatController,
                      onchange: (value) {
                        String chat = value;
                        setState(() {
                          if (chat.trim().isNotEmpty) {
                            onchange = true;
                          } else {
                            onchange = false;
                          }
                        });
                      },
                      width: CustomWidth(context) * 0.8,
                    ),
                    InkWell(
                        onTap: () async {
                          if (onchange == true) {
                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc(
                                "${FirebaseAuth.instance.currentUser!.email.toString().trim()}")
                                .collection("MyUser")
                                .doc("${widget.useremail}").set({
                              "Email":widget.useremail,
                              "Name":widget.userName
                            });
                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc(
                                    "${FirebaseAuth.instance.currentUser!.email.toString().trim()}")
                                .collection("MyUser")
                                .doc("${widget.useremail}")
                                .collection("Messages")
                                .doc()
                                .set({
                              "Message": chatController.text.trim(),
                              "IsMe": true
                            });

                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc("${widget.useremail}")
                                .collection("MyUser")
                                .doc(
                                "${FirebaseAuth.instance.currentUser!.email.toString().trim()}").set(
                                {
                                  "Name":FirebaseAuth.instance.currentUser!.displayName,
                                  "Email":FirebaseAuth.instance.currentUser!.email,
                                });
                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc("${widget.useremail}")
                                .collection("MyUser")
                                .doc(
                                    "${FirebaseAuth.instance.currentUser!.email.toString().trim()}")
                                .collection("Messages")
                                .doc()
                                .set({
                              "Message": chatController.text.trim(),
                              "IsMe": false
                            });
                            setState(() {
                              chatController.text = "";
                              onchange = false;
                            });
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColor.defaultcolor,
                          child: Icon(
                            onchange == false
                                ? Icons.keyboard_voice_rounded
                                : Icons.send,
                            color: AppColor.white,
                          ),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
