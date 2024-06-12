

import 'package:chat_app/Screen/call_page.dart';
import 'package:chat_app/Screen/chat_page.dart';
import 'package:chat_app/Screen/settings_page.dart';
import 'package:chat_app/Screen/update_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarExample extends StatefulWidget {

  static  final List<Widget> _widgetOptions = [
      updatePage(),
      callPage(),
      chatPage(),
      settingPage()
  ];

  @override
  State<BottomNavigationBarExample> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0 ;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BottomNavigationBarExample._widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'updates',
             // backgroundColor: Colors.black87
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'call',
              //backgroundColor: Colors.black87
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'chat',
           //   backgroundColor: Colors.black87

          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
           // backgroundColor: Colors.black87,

          ),
        ],

        currentIndex: _selectedIndex,
        selectedItemColor: Colors.greenAccent,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(color: Colors.grey),

      ),
    );
  }
}
