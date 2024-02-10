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
  String? currentUser = AuthService.firebase().currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white12,
        appBar: AppBar(
          title: const Text(
            "Vibe",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
          ),
          toolbarHeight: 50,
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        // floatingActionButton: IconButton(
        //   onPressed: () {},
        //   icon: Icon(
        //     Icons.arrow_upward_rounded,
        //     size: 60,
        //     color: Colors.white,
        //   ),
        // ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("User Posts")
              .orderBy('TimeStamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(snapshot.data!.docs.length!=0)
              {
                return ListView.builder(
                  reverse: true,
                  physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.fast),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final posts = snapshot.data!.docs[index];
                    return Posts(
                      user: posts["UserEmail"],
                      currentUser: currentUser!,
                      message: posts["Message"],
                      timestamp: posts["TimeStamp"],
                      postId: posts.id,
                      likes: List<String>.from(posts['Likes'] ?? []),
                    );
                  },
                );
              }
              else{
                return Center(child: const Text("Welcome",style: TextStyle(color: Colors.white,fontSize: 40),));
              }
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
