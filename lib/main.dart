import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vibe/constants/routes.dart';
import 'package:vibe/services/auth_service.dart';
import 'package:vibe/views/home_view.dart';
import 'package:vibe/views/login_view.dart';
import 'package:vibe/views/mobile_layout_view.dart';

import 'views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Vibe',
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
    routes: {
      registerRoute: (context) => const RegisterView(),
      loginRoute: (context) => const LoginView(),
      mobileLayout:(context) => const MobileLayout(),
    },
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState){

          case ConnectionState.done:
            final user=AuthService.firebase().currentUser;
            if(user==null){
              return const LoginView();
            }
            else{
              return MobileLayout();
            }
          default:
            return Center(child: CircularProgressIndicator(strokeWidth: 7,backgroundColor: Colors.white70,));
        }
      },
    );
  }
}
