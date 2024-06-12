import 'package:chat_app/Models/country_models.dart';
import 'package:chat_app/elements/country_list.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
class ChangePhoneNumber extends StatefulWidget{
  final Country country;

  const ChangePhoneNumber({super.key, required this.country});
  @override
  State<ChangePhoneNumber> createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {

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

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       actions: [
         TextButton(
           onPressed: () {
             Navigator.of(context).pop(); },
           child: Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),),

         Spacer(),

         Text("Change number",
           style: TextStyle(color: Colors.black,
               fontWeight: FontWeight.bold,fontSize: 18),),
         Spacer(),
       ],
     ),
     body: Padding(
       padding: const EdgeInsets.all(15),
       child: Column(
         children: [
           SizedBox(height: 25,),
           Text("YOUR OLD COUNTRY CODE AND PHONE NUMBER:"),
                SizedBox(height: 5,),

                Container(
               //   color: Colors.red,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                     Container(
                       height: 40,
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Theme.of(context).backgroundColor,
                         boxShadow: [
                           BoxShadow(
                             color: Theme.of(context).disabledColor.withOpacity(0.1),
                             offset: Offset(4, 4),
                             blurRadius: 10,
                           )
                         ],
                       ),
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                           Text(selectedCountry.name,style: TextStyle(color: Colors.green),),
                             IconButton(
                               onPressed: () {
                                 Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                     CountryList(
                                   onCountrySelected: _updateCountry,
                                 ),));
                               },
                               icon: Icon(Icons.arrow_forward_ios,size: 15,),)
                           ],
                         ),
                       ),
                     ),

                   Divider(
                     height: 0.1,
                   ),

                     Container(
                           height: 40,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: Theme.of(context).backgroundColor,
                             boxShadow: [
                               BoxShadow(
                                 color: Theme.of(context).disabledColor.withOpacity(0.1),
                                 offset: Offset(4, 4),
                                 blurRadius: 10,
                               ),
                             ],
                           ),
                           child: TextField(
                             decoration: InputDecoration(
                               hintText: 'OLD MOBILE NUMBER',
                               //errorText: controller.numberError.value.isEmpty ? null : controller.numberError.value,
                               border: InputBorder.none,
                               contentPadding: EdgeInsets.symmetric(horizontal: 16),
                             ),
                             maxLines: 1,
                             keyboardType: TextInputType.phone,
                           ),)


                                   ],
                                 ),
                  ),
                ),

           Text("YOUR NEW COUNTRY CODE AND PHONE NUMBER:"),
           SizedBox(height: 5,),
           Container(
             //   color: Colors.red,
             height: 200,
             width: MediaQuery.of(context).size.width,
             child: Padding(
               padding: const EdgeInsets.all(10),
               child: Column(
                 children: [
                   Container(
                     height: 40,
                     width: MediaQuery.of(context).size.width,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Theme.of(context).backgroundColor,
                       boxShadow: [
                         BoxShadow(
                           color: Theme.of(context).disabledColor.withOpacity(0.1),
                           offset: Offset(4, 4),
                           blurRadius: 10,
                         )
                       ],
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(selectedCountry.name,style: TextStyle(color: Colors.green),),
                           IconButton(
                             onPressed: () {
                               Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                   CountryList(
                                     onCountrySelected: _updateCountry,
                                   ),));
                             },
                             icon: Icon(Icons.arrow_forward_ios,size: 15,),)
                         ],
                       ),
                     ),
                   ),

                   Divider(
                     height: 0.1,
                   ),

                   Container(
                     height: 40,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Theme.of(context).backgroundColor,
                       boxShadow: [
                         BoxShadow(
                           color: Theme.of(context).disabledColor.withOpacity(0.1),
                           offset: Offset(4, 4),
                           blurRadius: 10,
                         ),
                       ],
                     ),
                     child: TextField(
                       decoration: InputDecoration(
                         hintText: 'NEW MOBILE NUMBER',
                         //errorText: controller.numberError.value.isEmpty ? null : controller.numberError.value,
                         border: InputBorder.none,
                         contentPadding: EdgeInsets.symmetric(horizontal: 16),
                       ),
                       maxLines: 1,
                       keyboardType: TextInputType.phone,
                     ),)


                 ],
               ),
             ),
           ),

         Spacer(),

           Container(
             height: 50,
             decoration: BoxDecoration(
                 color: Colors.greenAccent,
                 borderRadius:BorderRadius.circular(24)
             ),
             child: Material(
               color: Colors.transparent,
               child: InkWell(
                 onTap: (){
                 
                 },
                 borderRadius: BorderRadius.circular(24),
                 child: Center(child: Text("Change number")),
               ),
             ),
           )



         ],
       ),
     ),
   );
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;
Future<void> reauthenticateWithNewPhoneNumber(String newPhoneNumber) async {
  await _auth.verifyPhoneNumber(
    phoneNumber: newPhoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.reauthenticateWithCredential(credential);
      }
    },
    verificationFailed: (FirebaseAuthException e) {
      print('Verification failed: ${e.message}');
    },
    codeSent: (String verificationId, int? resendToken) {
      // Store the verificationId and resendToken for later use.
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}

