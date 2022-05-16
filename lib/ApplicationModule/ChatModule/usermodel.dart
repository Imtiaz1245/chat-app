import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel {
  String name, email, pic,time,message;
  bool isme;

  UserModel({
    required this.name,
    required this.time,
    required this.message,
    required this.email,
    required this.isme,
    required this.pic,
  });


  factory UserModel.fromJson(DocumentSnapshot snapshot){
    return UserModel(name: (snapshot.data() as dynamic)["Name"]??" ",
        email: (snapshot.data() as dynamic)["Email"]??" ",
        message: (snapshot.data() as dynamic)["Message"]??" ",
        time: (snapshot.data() as dynamic)["Time"]??" ",
        isme: (snapshot.data() as dynamic)["IsMe"]??false,
        pic: (snapshot.data() as dynamic)["PicUrl"]??" ");
  }
  Map<String,dynamic> toJson(UserModel model){
    return {
      "Name":model.name,
      "Email":model.email,
      "IsMe":model.isme,
      "PicUrl":model.pic,
    };
  }

  static List<UserModel> JsonToListView(List<DocumentSnapshot >jsonList){
    return jsonList.map((e) => UserModel.fromJson(e)).toList();
  }
}
