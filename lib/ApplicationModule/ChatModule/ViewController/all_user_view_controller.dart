import 'package:firebaseflutter/ApplicationModule/ChatModule/View/all_users_view.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/app_colors.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/default_text_view.dart';
import 'package:firebaseflutter/ApplicationModule/Utills/height_width.dart';
import 'package:flutter/material.dart';

class AllUserViewController extends StatefulWidget {
  const AllUserViewController({Key? key}) : super(key: key);

  @override
  State<AllUserViewController> createState() => _AllUserViewControllerState();
}

class _AllUserViewControllerState extends State<AllUserViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.defaultcolor,
        title: DefaultTextView(
          text: "Unique Chat",
          textcolor: AppColor.white,
          fontSize: 20.0,
          fontweight: FontWeight.bold,
        ),
        actions: [
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.nightlight_round,size: 25,),
          ),
          SizedBox(
            width: 5,
          ),
          IconButton(
            onPressed: () {},
            icon:      Icon(Icons.more_vert),
          ),

        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: SizedBox(
        height: CustomHeight(context),
        width: CustomWidth(context),
        child: AllUsersView(),
      )),
    );
  }
}
