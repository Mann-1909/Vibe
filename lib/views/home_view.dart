import 'package:flutter/material.dart';
import 'package:vibe/services/auth_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text("Vibe",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black12,
      ),
    );
  }
}
