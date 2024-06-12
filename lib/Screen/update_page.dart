import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class updatePage extends StatefulWidget {
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<updatePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _onMenuItemSelected(BuildContext context, String value) {
    switch (value) {
      case 'camera':
        _pickImage();
        break;
      case 'edit':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Container(
              height: 20,
              width: 20,
              child: Icon(Icons.more_horiz, size: 10, color: Colors.black,),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey
              ),
            ),
            SizedBox(height: 5,),
            Text("Updates", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: 5,),
            TextField(
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
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        _pickImage();
                      },
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditPage()),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          //  SizedBox(height: 5),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/img3.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {},
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.blue,
                                  child: PopupMenuButton<String>(
                                    icon: Icon(Icons.camera_alt,
                                      color: Colors.white, size: 9,),
                                    onSelected: (value) {
                                      _onMenuItemSelected(context, value);
                                    },
                                    itemBuilder: (BuildContext context) => [
                                      PopupMenuItem(
                                        value: 'camera',
                                        child: Row(
                                          children: [
                                            Icon(Icons.camera_alt, color: Colors.black),
                                            SizedBox(width: 10),
                                            Text('Camera'),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 'edit',
                                        child: Row(
                                          children: [
                                            Icon(Icons.edit, color: Colors.black),
                                            SizedBox(width: 10),
                                            Text('Edit Text'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  _buildStatusTile(
                    name: 'Amalu',
                    time: '2 minutes ago',
                    imageUrl: 'assets/images/img1.jpg',
                  ),
                  _buildStatusTile(
                    name: 'Unnimaya',
                    time: '5 minutes ago',
                    imageUrl: 'assets/images/img2.jpg',
                  ),
                  _buildStatusTile(
                    name: 'Sai',
                    time: '15 minutes ago',
                    imageUrl: 'assets/images/img2.jpg',
                  ),
                  // Add more status tiles as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTile({required String name, required String time, required String imageUrl}) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(name),
      subtitle: Text(time),
      onTap: () {
        // Add onTap action if needed
      },
    );
  }
}

class EditPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Write something...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle the save or submit action
                print('Submitted: ${_controller.text}');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}