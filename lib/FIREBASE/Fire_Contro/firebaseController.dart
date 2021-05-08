import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:Butomy/Components/global_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseController {
  static FirebaseController get instanace => FirebaseController();

  // Save Image to Storage
  Future<String> saveUserImageToFirebaseStorage(userId,userName,userIntro,userImageFile) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId',userId);
      await prefs.setString('name',userName);
      await prefs.setString('username',userIntro);

      String filePath = 'userImages/$userId';
      final StorageReference storageReference = FirebaseStorage().ref().child(filePath);
      final StorageUploadTask uploadTask = storageReference.putFile(userImageFile);

      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      String imageURL = await storageTaskSnapshot.ref.getDownloadURL(); // Image URL from firebase's image file
      String result = await saveUserDataToFirebaseDatabase(userId,userName,userIntro);
      return result;
    }catch(e) {
      print(e.message);
      return null;
    }
  }

  Future<String> sendImageToUserInChatRoom(croppedFile,chatID) async {
    try {
      String imageTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      String filePath = 'chatrooms/$chatID/$imageTimeStamp';
      final StorageReference storageReference = FirebaseStorage().ref().child(filePath);
      final StorageUploadTask uploadTask = storageReference.putFile(croppedFile);
      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      String result = await storageTaskSnapshot.ref.getDownloadURL();
      return result;
    }catch(e) {
      print(e.message);
    }
  }

  // About Firebase Database
  Future<String> saveUserDataToFirebaseDatabase(userId,name,username) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final QuerySnapshot result = await Firestore.instance.collection('users').where('FCMToken', isEqualTo: prefs.get('FCMToken')).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      String myID = userId;
      if (documents.length == 0) {
        await Firestore.instance.collection('users').document(userId).setData({
          'userId':userId,
          'name':name,
          'username':username,
          'createdAt': DateTime.now().millisecondsSinceEpoch,
          'FCMToken':prefs.get('FCMToken')?? 'NOToken',
        });
      }else {
        String userID = documents[0]['userId'];
        myID = userID;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId',myID);
        await Firestore.instance.collection('users').document(userID).updateData({
          'name':name,
          'username':username,
          'createdAt': DateTime.now().millisecondsSinceEpoch,
          'FCMToken':prefs.get('FCMToken')?? 'NOToken',
        });
      }

      return myID;
    }catch(e) {
      print(e.message);
      return null;
    }
  }

  Future<void> updateUserToken(userID, token) async {
    await Firestore.instance.collection('users').document(userID).setData({
      'FCMToken':token,
    });

  }

  Future<void> savingdataofuser(userID, pic,fire_name,fire_username,fire_token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Firestore.instance.collection('users').document(userID).setData({
      'userImageUrl':pic.toString(),
      'userId':userID.toString(),
      'name':fire_name,
      'username':fire_username,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'FCMToken':fire_token
    });
  }



  Future<void> updateprofilepicture(userID, pic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Firestore.instance.collection('users').document(userID).updateData({
      'userImageUrl':pic.toString(),
    });
  }

  Future<void> updateToken(userID, tok) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Firestore.instance.collection('users').document(userID).updateData({
      'FCMToken':tok.toString(),
    });
  }



  Future<List<DocumentSnapshot>> takeUserInformationFromFBDB() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final QuerySnapshot result = await Firestore.instance.collection('users').where('FCMToken', isEqualTo: prefs.get('FCMToken') ?? 'None').getDocuments();
    return result.documents;
  }

  Future<int> getUnreadMSGCount() async{
    try {
      int unReadMSGCount = 0;
      SharedPreferences prefs = await SharedPreferences.getInstance();
//      if (targetID != 'NoId') {
        final QuerySnapshot chatListResult =
        await Firestore.instance.collection('users').document(timelineIdFoodi).collection('chatlist').getDocuments();
        final List<DocumentSnapshot> chatListDocuments = chatListResult.documents;
        for(var data in chatListDocuments) {
          final QuerySnapshot unReadMSGDocument = await Firestore.instance.collection('chatroom').
          document(data['chatID']).
          collection(data['chatID']).
          where('idTo', isEqualTo: timelineIdFoodi).
          where('isread', isEqualTo: false).
          getDocuments();

          final List<DocumentSnapshot> unReadMSGDocuments = unReadMSGDocument.documents;
          unReadMSGCount = unReadMSGCount + unReadMSGDocuments.length;

        }
      print("RRRRRRRRRRRRRRRRRRR MMMMMMMMMMMMMMMMMMM "+unReadMSGCount.toString());
      return  unReadMSGCount;

    }catch(e) {
      print(e.message);
    }
  }

  Future<int> getUnreadMSGCountBusiness(iddd) async{
    print("caliingggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggg "+iddd);
    try {
      int unReadMSGCount = 0;

//      if (targetID != 'NoId') {
      final QuerySnapshot chatListResult =
      await Firestore.instance.collection('users').document(iddd).collection('chatlist').getDocuments();
      final List<DocumentSnapshot> chatListDocuments = chatListResult.documents;
      for(var data in chatListDocuments) {
        final QuerySnapshot unReadMSGDocument = await Firestore.instance.collection('chatroom').
        document(data['chatID']).
        collection(data['chatID']).
        where('idTo', isEqualTo: iddd).
        where('isread', isEqualTo: false).
        getDocuments();

        final List<DocumentSnapshot> unReadMSGDocuments = unReadMSGDocument.documents;
        unReadMSGCount = unReadMSGCount + unReadMSGDocuments.length;

      }
      print("RRRRRRRRRRRRRRRRRRR MMMMMMMMMMMMMMMMMMM "+unReadMSGCount.toString());
      return  unReadMSGCount;

    }catch(e) {
      print(e.message);
    }
  }

  Future updateLstChatUser(String documentID,String lastMessage,chatID,myID,selectedUserID) async{
    await Firestore.instance
        .collection('users')
        .document(documentID)
        .updateData({
      'createdAt':DateTime.now().millisecondsSinceEpoch});
  }

  Future updateChatRequestField(String documentID,String lastMessage,chatID,myID,selectedUserID) async{
    await Firestore.instance
        .collection('users')
        .document(documentID)
        .collection('chatlist')
        .document(chatID)
        .setData({'chatID':chatID,
      'chatWith':documentID == myID ? selectedUserID : myID,
      'lastChat':lastMessage,
      'timestamp':DateTime.now().millisecondsSinceEpoch});
  }

  Future sendMessageToChatRoom(chatID,myID,selectedUserID,content,messageType) async {
    await Firestore.instance
        .collection('chatroom')
        .document(chatID)
        .collection(chatID)
        .document(DateTime.now().millisecondsSinceEpoch.toString()).setData({
      'idFrom': myID,
      'idTo': selectedUserID,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'content': content,
      'type':messageType,
      'isread':false,
    });
  }

  Future deleteMessageFromChatRoom(chatID,doc) async {
    await Firestore.instance
        .collection('chatroom')
        .document(chatID)
        .collection(chatID)
        .document(doc).delete();
  }
}