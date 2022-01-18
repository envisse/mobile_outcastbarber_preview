import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_outcastbarber/services/repository/firebase/authentication.dart';
import 'package:mobile_outcastbarber/views/screen/export.dart';
import 'package:provider/provider.dart';

class MiddlewareAuth extends StatelessWidget {
  final Widget screen;
  MiddlewareAuth({required this.screen});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            initialData: null),
      ],
      child: Authenticationchecker(screen: screen),
    );
  }
}

class Authenticationchecker extends StatelessWidget {
  final Widget screen;
  Authenticationchecker({required this.screen});
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return screen;
    }
    
    return LoginScreen();
  }
}
