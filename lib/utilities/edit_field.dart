import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vibe/services/auth_service.dart';

Future<void> editField(BuildContext context,String field) async {

  final userCollection=FirebaseFirestore.instance.collection('Users');

  String email = AuthService.firebase().currentUser!.email!;
  String newValue = '';
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.grey[500],
      title: Text(
        "Edit " + field,
        style: TextStyle(color: Colors.white),
      ),
      content: TextField(
        autofocus: true,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Enter new $field",
          hintStyle: TextStyle(color: Colors.white),
        ),
        onChanged: (value) {
          newValue = value;
        },
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            )),
        TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ))
      ],
    ),
  );
  if(newValue.trim().length>0){
    await userCollection.doc(email).update({field:newValue});
  }

}