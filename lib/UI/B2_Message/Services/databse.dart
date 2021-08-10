// // import 'package:cloud_firestore/cloud_firestore.dart';
//
// // import 'package:cloud_firestore/cloud_firestore.dart';
//
// class DatabaseMethods {
//   Future<void> addUserInfo(userData) async {
//     Firestore.instance.collection("users").add(userData).catchError((e) {
//       print(e.toString());
//     });
//   }
//
//   getUserInfo(String email) async {
//     return Firestore.instance
//         .collection("users")
//         .where("userEmail", isEqualTo: email)
//         .getDocuments()
//         .catchError((e) {
//       print(e.toString());
//     });
//   }
//
//   searchByName(String searchField) {
//     return Firestore.instance
//         .collection("users")
//         .where('userName', isEqualTo: searchField)
//         .getDocuments();
//   }
//
//   Future<bool> addChatRoom(chatRoom, chatRoomId, time) {
//     Firestore.instance
//         .collection("chatRoom")
//         .document(chatRoomId)
//         .collection("chats")
//         .document(time)
//         .setData(chatRoom)
//         .catchError((e) {
//       print(e);
//     });
//   }
//
//   getChats(String chatRoomId) async {
//     return Firestore.instance
//         .collection("chatRoom")
//         .document(chatRoomId)
//         .collection("chats")
//         .orderBy('time')
//         .snapshots();
//   }
//
//   Future<void> addMessage(String chatRoomId, chatMessageData, time) {
//     Firestore.instance
//         .collection("chatRoom")
//         .document(chatRoomId)
//         .collection("chats")
//         .document(time)
//         .setData(chatMessageData)
//         .catchError((e) {
//       print(e.toString());
//     });
//   }
//
//   getUserChats(String itIsMyName) async {
//     return await Firestore.instance
//         .collection("chatRoom")
//         .where('users', arrayContains: itIsMyName)
//         .snapshots();
//   }
// }
