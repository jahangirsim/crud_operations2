import 'package:crud_operations2/product_screen.dart';
import 'package:flutter/material.dart';

class UserApp extends StatelessWidget {
  const UserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white
        )
      ),
      home: const UserScreen(),
    );
  }
}
