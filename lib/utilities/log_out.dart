import 'package:flutter/material.dart';
import 'package:vibe/constants/routes.dart';
import 'package:vibe/services/auth_service.dart';

import 'show_logout_dialog.dart';

class LogOutBtn extends StatelessWidget {
  const LogOutBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return  IconButton(
      onPressed: () async {
        final shouldlogout = await showLogoutDialog(context);
        if (shouldlogout) {
          await AuthService.firebase().logout();
          if(!context.mounted){
            CircularProgressIndicator();
          }
          Navigator.of(context).pushNamedAndRemoveUntil(
            loginRoute,
                (route) => false,
          );
        }
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
    );
  }
}
