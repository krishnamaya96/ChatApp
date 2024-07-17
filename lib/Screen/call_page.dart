import 'package:chat_app/elements/call_link.dart';
import 'package:chat_app/elements/contact_page.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';

import '../elements/firestore_contacts.dart';

class callPage extends StatefulWidget{
  @override
  State<callPage> createState() => _callPageState();
}

class _callPageState extends State<callPage> {

  bool _showAllCalls = true;
  bool isAllCalls = false;

  // Sample data for calls
  final List<Map<String, String>> allCalls = [
    {'name': 'Amalu', 'time': '2 minutes ago', 'type': 'incoming'},
    {'name': 'Sai', 'time': '5 minutes ago', 'type': 'missed'},
    {'name': 'Unni', 'time': '10 minutes ago', 'type': 'incoming'},
    {'name': 'Rishi', 'time': '15 minutes ago', 'type': 'missed'},
    {'name': 'Amalu', 'time': '2 minutes ago', 'type': 'incoming'},
    {'name': 'Sai', 'time': '5 minutes ago', 'type': 'missed'},
    {'name': 'Unni', 'time': '10 minutes ago', 'type': 'incoming'},
    {'name': 'Rishi', 'time': '15 minutes ago', 'type': 'missed'},
    {'name': 'Amalu', 'time': '2 minutes ago', 'type': 'incoming'},
    {'name': 'Sai', 'time': '5 minutes ago', 'type': 'missed'},
    {'name': 'Unni', 'time': '10 minutes ago', 'type': 'incoming'},
    {'name': 'Rishi', 'time': '15 minutes ago', 'type': 'missed'},
    {'name': 'Amalu', 'time': '2 minutes ago', 'type': 'incoming'},
    {'name': 'Sai', 'time': '5 minutes ago', 'type': 'missed'},
    {'name': 'Unni', 'time': '10 minutes ago', 'type': 'incoming'},
    {'name': 'Rishi', 'time': '15 minutes ago', 'type': 'missed'},
    {'name': 'Amalu', 'time': '2 minutes ago', 'type': 'incoming'},
    {'name': 'Sai', 'time': '5 minutes ago', 'type': 'missed'},
    {'name': 'Unni', 'time': '10 minutes ago', 'type': 'incoming'},
    {'name': 'Rishi', 'time': '15 minutes ago', 'type': 'missed'},
    {'name': 'Amalu', 'time': '2 minutes ago', 'type': 'incoming'},
    {'name': 'Sai', 'time': '5 minutes ago', 'type': 'missed'},
    {'name': 'Unni', 'time': '10 minutes ago', 'type': 'incoming'},
    {'name': 'Rishi', 'time': '15 minutes ago', 'type': 'missed'},
  ];

  List<Contact> _contacts = [];
  bool _isLoading = false;


  Future<void> _getContacts() async {
    setState(() {
      _isLoading = true;
    });

    // Request permission to access contacts
    if (await Permission.contacts.request().isGranted) {
      // Fetch contacts
      List<Contact> contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts;
       // _contactsFetched = true;
        _isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContactsPage(contacts: _contacts),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    List<Map<String, String>> displayedCalls = _showAllCalls
        ? allCalls
        : allCalls.where((call) => call['type'] == 'missed').toList();

   return Scaffold(
      appBar: AppBar(
      leading: GestureDetector(
        child: Container(
          height: 30,
          width: 30,
          margin: EdgeInsets.all(8), // Optional: margin around the container
          padding: EdgeInsets.all(8), // Padding inside the container
          decoration: BoxDecoration(
            color: Colors.grey, // Background color of the container
            shape: BoxShape.circle, // Shape of the container
          ),
          child: Icon(
            Icons.more_horiz,
            color: Colors.black, // Color of the icon
          ),
        ),
      ),

        actions: [
          CustomSwitch(
            value: _showAllCalls,
            onChanged: (value) {
              setState(() {
                _showAllCalls = value;
              });
            },
            activeText: "All",
            inactiveText: 'Missed ',

          ),

          SizedBox(width:50 ,),

          GestureDetector(
            onTap: (){
              _getContacts();
              //Get.off(RegisteredUsersList());
            },
            //_getContacts,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: Icon(Icons.add,color: Colors.black,),
            ),),


          SizedBox(width:20 ,),
      ],
      ),

    body:  _isLoading
        ? Center(
      child: CircularProgressIndicator(),
    )
        :Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Calls",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),

          SizedBox(height: 10,),

          Container(
            height: 50,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey.shade100,
                filled: true,
                hintText: 'Search',
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ),
          ),

          SizedBox(height: 10,),

          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade400,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                     shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    height: 60,
                    width: 60,
                    child: Icon(Icons.link,color: Colors.black,),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return DraggableScrollableSheet(
                          initialChildSize: 0.5,  // The initial height is 50% of the screen
                          minChildSize: 0.5,  // The minimum height is 50% of the screen
                          maxChildSize: 1.0,  // The maximum height is 100% of the screen
                          expand: false,
                          builder: ((context, scrollController) => callLink())
                        );
                      },
                    );

                  },
                  child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Create call link",
                      style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold,
                      fontSize: 20),),
                    Text("Share a link for your Whatsapp call",
                      style: TextStyle(color: Colors.black,
                          ),)
                  ],
                ))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedCalls.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: Icon(
                      color: Colors.red,
                      displayedCalls[index]['type'] == 'missed'
                          ? Icons.call_missed
                          : Icons.call,
                    ),

                  ),
                  title: Text(displayedCalls[index]['name']!),
                  subtitle: Text(displayedCalls[index]['time']!),
                );
              },
            ),
          ),
        ],
      ),
    ),
   );
  }
}



class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String activeText;
  final String inactiveText;


  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.activeText,
    required this.inactiveText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 200,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: value ? Colors.grey : Colors.grey,
        ),

        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
              left: value ? 200 - 100 : 0,
              child: Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  //shape: BoxShape.circle,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  inactiveText,
                  style: TextStyle(
                    color: !value ? Colors.white : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 50,
              top: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  activeText,
                  style: TextStyle(
                    color: value ? Colors.white : Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}








