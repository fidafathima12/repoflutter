import 'package:bridal_hub/presentation/artist/Manageprofile.dart';
import 'package:bridal_hub/presentation/artist/adddressmodel.dart';
import 'package:bridal_hub/presentation/artist/addmodels.dart';
import 'package:bridal_hub/presentation/artist/feedback.dart';
import 'package:bridal_hub/presentation/artist/managebookiingss.dart';
import 'package:bridal_hub/presentation/artist/managebooking.dart';
import 'package:bridal_hub/presentation/artist/previouswork.dart';
import 'package:bridal_hub/presentation/artist/viewbooking.dart';
import 'package:bridal_hub/presentation/artist/viewnotification.dart';
import 'package:bridal_hub/presentation/artist/viewpayment.dart';
import 'package:bridal_hub/presentation/artist/viewreview.dart';
import 'package:bridal_hub/login/loginpage.dart';
import 'package:bridal_hub/services/artist/managebooking.dart';
import 'package:bridal_hub/services/artist/manageprofike.dart';
import 'package:bridal_hub/services/artist/viewpayment.dart';
import 'package:bridal_hub/services/artist/viewreview.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ARTIST', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 18, 175, 196),
        elevation: 10,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Notifi()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildButton(
              'Add Previous Work',
              const Color.fromARGB(255, 72, 159, 200),
              const Color.fromARGB(255, 25, 152, 211),
              Icons.work,
              ()async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreviousWork()),
                );
              },
            ),
            // buildButton(
            //   'Add Models',
            //   const Color.fromARGB(255, 72, 168, 226),
            //   const Color.fromARGB(255, 25, 152, 226),
            //   Icons.add_circle,
            //   () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => AddModels()),
            //     );
            //   },
            // ),
            buildButton(
              'View Bookings',
              const Color.fromARGB(255, 94, 142, 231),
              const Color.fromARGB(255, 51, 129, 231),
              Icons.calendar_today,
              () async{
                // List<Map<String,dynamic>>bookingdata=await artistviewBookingsApi(); 
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminViewBookingsScreen()),
                );
              },
            ),
            buildButton(
              'payments',
              const Color.fromARGB(255, 62, 135, 212),
              const Color.fromARGB(195, 23, 127, 212),
              Icons.manage_accounts,
              () async{
                List<Map<String,dynamic>>paymentdata=await viewPaymnetApi(); 
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentDetailsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.deepPurple),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome User!',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Manage Profile'),
              onTap: ()async {
                Map<String,dynamic>profiledata=await getProfile();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage(profile: profiledata,)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text('View Review'),
              onTap: ()async {
                List<Map<String,dynamic>>reviewData=await viewreviewapi();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewReviewsScreen(reviews:reviewData)),
                );
              },
            ),
        
            // ListTile(
            //   leading: Icon(Icons.help_outline),
            //   title: Text('Feedback'),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ViewFeedbacksScreen()),
            //     );
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDressModelScreen()),
          );
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget buildButton(String label, Color startColor, Color endColor, IconData icon, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
