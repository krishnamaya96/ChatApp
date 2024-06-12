import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Screen/individual_chat.dart';

class RegisteredUsersList extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String getFirstTwoDigits(String phoneNumber) {
    return phoneNumber.substring(3, 5); // Assuming phone number starts with '+'
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('user').orderBy('createdAt').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No registered users'));
          }
          var users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {

              var user = users[index];
              String phoneNumber = user['phoneNumber'];
              String firstTwoDigits = getFirstTwoDigits(phoneNumber);

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    firstTwoDigits,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(user['phoneNumber']),
               // onTap: (){
               //   Navigator.push(
               //     context,
               //     MaterialPageRoute(
               //       builder: (context) => ChatScreen()
               //     ),
               //   );
               // },
               // subtitle: Text('User ID: ${user['uid']}'),
              );
            },
          );
        },
      ),
    );
  }
}
