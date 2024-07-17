import 'package:bulleted_list/bulleted_list.dart';
import 'package:chat_app/Models/country_models.dart';
import 'package:chat_app/Sub_Screens/accounts/phone_verification2.dart';
import 'package:chat_app/elements/country_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Screen/mobile_verification.dart';
import '../../Screen/spalsh_screen.dart';

class DeleteAccount extends StatefulWidget{

  final Country country;

  const DeleteAccount({super.key, required this.country});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {

  late Country selectedCountry;

  @override
  void initState() {
    super.initState();
    selectedCountry = widget.country;
  }

  void _updateCountry(Country newCountry) {
    setState(() {
      selectedCountry = newCountry;
    });
  }

   List <String> deleteList =[
    "Dlete your account info and profile photo",
    "Delete you from all WhatsApp groups",
    "Delete your message history on this phone",
    "Delete any channel that you created"];


  final FirebaseAuth _auth = FirebaseAuth.instance;

   _deleteUserAccount() async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        await user.delete();

        Fluttertoast.showToast(
            msg: "User account deleted successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SplashScreen(),));
        // Account deleted successfully
        print("User account deleted successfully");
      } catch (e) {
        if (e is FirebaseAuthException && e.code == 'requires-recent-login') {
          Fluttertoast.showToast(
            msg: "Reauthentication Required:",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MobileVerification (),));
          // The user's credential is too old and they need to log in again
          // Handle re-authentication here
          print("Re-authentication required");
        } else {
          // Handle other errors
          print("Error deleting user: $e");
        }
      }
    } else {

      Fluttertoast.showToast(
          msg: "No user is signed in",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0
      );
      // No user is signed in
      print("No user is signed in");
    }
  }

  @override
  Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(
           actions: [
             IconButton(
                 onPressed: () {
                   Navigator.of(context).pop(); },

                 icon: Icon(Icons.arrow_back_ios)),
             Spacer(),
             Text("Delete my account",
               style: TextStyle(color: Colors.black,
                   fontWeight: FontWeight.bold,fontSize: 18),),
             Spacer(),
           ],
         ),

         body: Padding(
           padding: const EdgeInsets.all(15),
           child: Column(
             children: [
               Row(
                 children: [
                   Icon(Icons.warning_amber,color: Colors.red,size: 30,),
                   SizedBox(width: 10),
                   Text("Deleting your account will:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                 ],
               ),
             BulletedList(
               listItems:deleteList,
               listOrder: ListOrder.ordered,
               style: TextStyle(color: Colors.black,fontSize: 15),
             ),

               SizedBox(height:30),

               // Container(
               //   height: 150,
               //   child: Padding(
               //     padding: const EdgeInsets.all(10),
               //     child: Column(
               //       children: [
               //         Container(
               //           height: 40,
               //           width: MediaQuery.of(context).size.width,
               //           decoration: BoxDecoration(
               //             borderRadius: BorderRadius.circular(10),
               //             color: Theme.of(context).backgroundColor,
               //             boxShadow: [
               //               BoxShadow(
               //                 color: Theme.of(context).disabledColor.withOpacity(0.1),
               //                 offset: Offset(4, 4),
               //                 blurRadius: 10,
               //               )
               //             ],
               //           ),
               //           child: Padding(
               //             padding: const EdgeInsets.all(8.0),
               //             child: Row(
               //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               //               children: [
               //                 Text(selectedCountry.name,style: TextStyle(color: Colors.green),),
               //                 IconButton(
               //                   onPressed: () {
               //                     Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
               //                         CountryList(
               //                           onCountrySelected: _updateCountry,
               //                         ),));
               //                   },
               //                   icon: Icon(Icons.arrow_forward_ios,size: 15,),)
               //               ],
               //             ),
               //           ),
               //         ),
               //
               //         Divider(
               //           height: 0.1,
               //         ),
               //
               //         Container(
               //           height: 40,
               //           decoration: BoxDecoration(
               //             borderRadius: BorderRadius.circular(10),
               //             color: Theme.of(context).backgroundColor,
               //             boxShadow: [
               //               BoxShadow(
               //                 color: Theme.of(context).disabledColor.withOpacity(0.1),
               //                 offset: Offset(4, 4),
               //                 blurRadius: 10,
               //               ),
               //             ],
               //           ),
               //           child: TextField(
               //             decoration: InputDecoration(
               //               hintText: 'your phone number',
               //               //errorText: controller.numberError.value.isEmpty ? null : controller.numberError.value,
               //               border: InputBorder.none,
               //               contentPadding: EdgeInsets.symmetric(horizontal: 16),
               //             ),
               //             maxLines: 1,
               //             keyboardType: TextInputType.phone,
               //           ),),
               //       ],
               //     ),
               //   ),
               // ),



             GestureDetector(
               onTap: (){
                 Get.off(_deleteUserAccount());
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => _deleteUserAccount(),));

               },
               child:Container(
                 height: 50,
                 width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: Colors.grey.shade200
                 ),
                 child: Center(
                     child: Text("Delete my account",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
               ),),

               SizedBox(height: 30,),

             GestureDetector(
               onTap: (){
                 Get.off(PhoneVerificationScreen());
               },
               child:Container(
                 height: 50,
                 width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: Colors.grey.shade200
                 ),
                 child: Center(
                     child: Text("Change Number",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),)),
               ),)

             ],),),
       );
  }
}


