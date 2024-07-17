// import 'package:chat_app/Controller/userController_get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import '../Models/chatroom.dart';
// import '../Services/chatListServices.dart';
//
//
// class ChatRoomController extends GetxController {
//   var chatRooms = <DocumentSnapshot>[].obs;
//   var currentUserId = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     UserController userController = Get.find<UserController>();
//     currentUserId.value = userController.currentUserId.value;
//     fetchChatRooms();
//   }
//
//   void fetchChatRooms() async {
//     if (currentUserId.value.isNotEmpty) {
//       print('Fetching chat rooms for user ID: ${currentUserId.value}');
//       try {
//         var chatRoomsQuery = await FirebaseFirestore.instance
//             .collection('chatRooms')
//             .where('participants', arrayContains: currentUserId.value)
//             .get();
//
//         chatRooms.value = chatRoomsQuery.docs;
//         if (chatRooms.isEmpty) {
//           print('No chat rooms found');
//         } else {
//           print('Fetched chat rooms: ${chatRooms.length}');
//         }
//       }
//       catch(e){
//         print('Error fetching chat rooms: $e');
//       }
//     }
//     else{
//     print('Current user ID is empty'); // Debug print
//
//     }
//   }
// }
