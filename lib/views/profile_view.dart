import 'package:flutter/material.dart';
import 'package:vibe/constants/routes.dart';
import 'package:vibe/services/auth_service.dart';

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
          backgroundColor: Colors.transparent,
          title: Text(
            "Profile",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
            Icon(
              Icons.account_circle,
              size: 200,
              color: Colors.white,
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
            Text(
              "Email-id: ${email}",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
            IconButton(
              onPressed: () async {
                await AuthService.firebase().logout();
                Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              tooltip: 'Log Out',
              enableFeedback: false,
              icon: Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
