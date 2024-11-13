import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keshflip_app/screens/notification_screen.dart';
import 'package:keshflip_app/screens/profile.dart';
import 'package:keshflip_app/screens/transaction_filter.dart';
import 'package:keshflip_app/screens/transaction_history.dart';
import 'package:keshflip_app/theme/text_styles.dart';

void main() {
  // Set the status bar color to white
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Set status bar color
      statusBarIconBrightness: Brightness.dark, // Set icon color to dark
      statusBarBrightness: Brightness.light, // For iOS status bar
    ),
  );
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
      // home: TransactionHistoryScreen(),
      home: TransactionHistoryScreen(),
    );
  }
}
