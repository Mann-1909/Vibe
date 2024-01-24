import 'package:flutter/material.dart';
import 'package:vibe/constants/routes.dart';
import 'package:vibe/services/auth_exceptions.dart';
import 'package:vibe/services/auth_service.dart';
import 'package:vibe/utilities/input_line.dart';
import 'package:vibe/utilities/show_error_dialog.dart';
import 'package:vibe/views/mobile_layout_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;

  late final TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent,
      appBar: AppBar(
        title: const Text(
          "Vibe",
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 40),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
            const Icon(Icons.lock_outline_rounded, size: 100),
            const Padding(padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
            InputBox(
              hint: 'Enter Your Email Address ',
              controller: _email,
              obscureText: false,
              type: TextInputType.emailAddress,
              suggestions: false,
              autocorrect: false,
            ),
            const Padding(padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
            InputBox(
                hint: "Enter Your Password",
                controller: _password,
                obscureText: true,
                type: null,
                suggestions: false,
                autocorrect: false),
            const Padding(padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  await AuthService.firebase().login(email: email, password: password);
                  Navigator.of(context).pushNamedAndRemoveUntil(mobileLayout, (route) => false);
                } on UserNotFoundAuthException {
                  await showErrorDialog(context, "User Not Found");
                } on WrongPasswordAuthException {
                  await showErrorDialog(context, "Wrong Password");
                } on GenericAuthException {
                  await showErrorDialog(context, "Authentication Error");
                }
              },
              child: Icon(Icons.arrow_forward, size: 80),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "New to Vibe?",
                  style: TextStyle(fontSize: 15),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => true);
                    },
                    child: const Text(
                      'Register Here',
                      style: TextStyle(fontSize: 15),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
