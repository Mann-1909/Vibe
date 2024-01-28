import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vibe/services/auth_service.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    textEditingController = TextEditingController();
    super.initState();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   textEditingController.dispose();
  //   super.dispose();
  // }
  Future<void> postMessage() async {
    if (textEditingController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('User Posts').add({
        'UserEmail': AuthService.firebase().currentUser!.email,
        'Message': textEditingController.text,
        'TimeStamp': Timestamp.now()
      });
    }
    final snackBar = SnackBar(
        backgroundColor: Colors.white10,
        content: const Text(
          "Posted Successfully! See Home Section",
          style: TextStyle(color: Colors.white),
        ));
    FocusManager.instance.primaryFocus?.unfocus();
    await ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() {
      textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white10,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Create Posts",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(children: [
            TextField(
              controller: textEditingController,
              keyboardType: TextInputType.multiline,
              minLines: 4,
              maxLines: null,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                filled: true,
                fillColor: Colors.black,
                hintText: "Write Something...",
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
            IconButton(
                color: Colors.blue,
                onPressed: postMessage,
                icon: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Post",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.white,
                    )
                  ],
                ))
          ]),
        ),
      ),
    );
  }
}
