import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vibe/utilities/like_button.dart';

class Posts extends StatefulWidget {
  final String user;
  final String currentUser;
  final String message;
  final Timestamp timestamp;
  final String postId;
  final List<String> likes;

  const Posts({
    super.key,
    required this.user,
    required this.message,
    required this.timestamp,
    required this.currentUser,
    required this.postId,
    required this.likes,
  });

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  bool isLiked = false;

  @override
  void initState() {
    // TODO: implement initState
    isLiked = widget.likes.contains(widget.currentUser);
    super.initState();
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);
    if (isLiked) {
      postRef.update({
        "Likes": FieldValue.arrayUnion([widget.currentUser])
      });
    } else {
      postRef.update({
        "Likes": FieldValue.arrayRemove([widget.currentUser])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.user == widget.currentUser ? Colors.white24 : Colors.white10,
        borderRadius: widget.user == widget.currentUser
            ? BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
            : BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      margin: widget.user == widget.currentUser
          ? EdgeInsets.fromLTRB(35, 7, 0, 7)
          : EdgeInsets.fromLTRB(0, 7, 35, 7),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Icon(
              Icons.account_circle,
              size: 40,
            ),
            Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user == widget.currentUser ? "Me" : widget.user,
                  style: TextStyle(color: Colors.white60, fontSize: 13),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
                Text(
                  widget.message,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 3)),
                Text(
                  widget.timestamp.toDate().toString().substring(11, 16) +
                      '  ' +
                      widget.timestamp.toDate().toString().substring(5, 7) +
                      '-' +
                      widget.timestamp.toDate().toString().substring(8, 10) +
                      '-' +
                      widget.timestamp.toDate().toString().substring(0, 4),
                  style: TextStyle(
                    color: Colors.white24,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //likebutton
                LikeButton(isLiked: isLiked, onTap: toggleLike),
                //likecount
                Text(widget.likes.length.toString(),style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
