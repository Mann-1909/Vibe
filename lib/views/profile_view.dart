import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vibe/constants/routes.dart';
import 'package:vibe/services/auth_service.dart';
import 'package:vibe/utilities/edit_field.dart';
import 'package:vibe/utilities/log_out.dart';
import 'package:vibe/utilities/show_logout_dialog.dart';
import 'package:vibe/utilities/text_box.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email = AuthService.firebase().currentUser!.email!;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white12,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Profile",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').doc(email).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                children: [
                  const Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white,
                  ),
                  Text(
                    email,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text("My Details", style: TextStyle(color: Colors.white)),
                  ),
                  //username
                  TextBox(
                    text: userData['username'],
                    sectionName: 'username',
                    onPressed: () => editField(context,"username"),
                  ),
                  TextBox(
                    text: userData['bio'],
                    sectionName: 'bio',
                    onPressed: () => editField(context,"bio"),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Text("My Posts", style: TextStyle(color: Colors.white)),
                  ),
                  const LogOutBtn()
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ' + snapshot.error.toString()),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
