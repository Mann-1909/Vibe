import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Posts extends StatelessWidget {
  final String user;
  final String message;
  final Timestamp timestamp;

  const Posts({
    super.key,
    required this.user,
    required this.message,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.fromLTRB(15, 7, 15, 7),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(children: [
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
              user,
              style: TextStyle(color: Colors.white60, fontSize: 13),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 2)),
            Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 3, 0, 3)),
            Text(
              timestamp.toDate().toString().substring(11, 16) +'  '+
                  timestamp.toDate().toString().substring(5,7)+'-'+
                  timestamp.toDate().toString().substring(8,10)+'-'+
                  timestamp.toDate().toString().substring(0, 4),
              style: TextStyle(
                color: Colors.white24,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
