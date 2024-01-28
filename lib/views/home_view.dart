import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vibe/services/auth_service.dart';
import 'package:vibe/views/posts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? currentUser=AuthService.firebase().currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white12,
        appBar: AppBar(
          title: Text(
            "Vibe",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("User Posts")
              .orderBy('TimeStamp', descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final posts = snapshot.data!.docs[index];
                  return Posts(
                    user: posts["UserEmail"]==currentUser?"Me":posts["UserEmail"],
                    message: posts["Message"], timestamp: posts["TimeStamp"],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
