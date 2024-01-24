import 'package:flutter/material.dart';
import 'package:vibe/constants/routes.dart';
import 'package:vibe/services/auth_exceptions.dart';
import 'package:vibe/services/auth_service.dart';
import 'package:vibe/utilities/general_dialog.dart';
import 'package:vibe/utilities/input_line.dart';
import 'package:vibe/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
              'Register',
              style: TextStyle(fontSize: 40),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
            const Icon(Icons.add_circle_outline_rounded, size: 100),
            const Padding(padding: EdgeInsets.fromLTRB(20, 5, 20, 5)),
            InputBox(
              hint: 'Enter Your Email Address',
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
            TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    await AuthService.firebase().createUser(email: email, password: password);
                    await AuthService.firebase().logout();
                    await generalDialog(context, "Login Once to Verify.");
                    Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  } on WeakPasswordAuthException {
                    await showErrorDialog(context, "Weak Password");
                  } on EmailAlreadyInUseAuthException {
                    await showErrorDialog(context, "Email is Already In Use");
                  } on InvalidEmailAuthException {
                    await showErrorDialog(context, "Invalid Email Entered");
                  } on GenericAuthException catch(e) {
                    await showErrorDialog(context, "Authentication Error");
                    print(e);
                  }
                },
                child: Icon(
                  Icons.arrow_forward,
                  size: 80,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already Registered?",
                  style: TextStyle(fontSize: 15),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                    },
                    child: const Text(
                      'Login here',
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
