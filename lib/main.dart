import 'package:bridal_hub/presentation/artist/Homescreen.dart';
import 'package:bridal_hub/presentation/artist/viewreview.dart';
import 'package:bridal_hub/login/loginpage.dart';
import 'package:bridal_hub/presentation/user/add_complaints.dart';
import 'package:bridal_hub/presentation/user/add_review.dart';
import 'package:bridal_hub/presentation/user/homepage.dart';
import 'package:bridal_hub/presentation/user/search_artist.dart';
import 'package:bridal_hub/presentation/user/view_bookingstatus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: 
LoginPage()          // BridalEleganceHome(),

          
      // ViewReviewsScreen(),
    );
  }
}
