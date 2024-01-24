import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white10,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            "Create Posts",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          TextField(
            controller: textEditingController,
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: null,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                hintText: "Write Something...", hintStyle: TextStyle(color: Colors.white70)),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
          IconButton(
              color: Colors.blue,
              onPressed: () {},
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
    );
  }
}
