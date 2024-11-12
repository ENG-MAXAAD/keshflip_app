import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keshflip_app/screens/notification_screen.dart';
import 'package:keshflip_app/screens/profile.dart';
import 'package:keshflip_app/screens/transaction_history.dart';
import 'package:keshflip_app/theme/text_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      // home: ProfileScreen(),
      // home: NotificationScreen(),
      home: TransactionHistoryScreen(),
    );
  }
}
