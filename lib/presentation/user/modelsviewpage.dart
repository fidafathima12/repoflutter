// import 'package:bridal_hub/services/loginApi.dart';
// import 'package:flutter/material.dart';

// class DressDetailsPage extends StatelessWidget {
//   final List<Map<String, dynamic>> modelImages;  // Accept modelImages as parameter

//   // Modify constructor to accept the modelImages list
//   DressDetailsPage({required this.modelImages});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dress Details'),
//         backgroundColor: Colors.teal,
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.all(16.0),
//         itemCount: modelImages.length,  // Use the length of modelImages
//         itemBuilder: (context, index) {
//           final dress = modelImages[index]; 
//           final imageurl=dress['modelimage'] ;
//           print("EEEEEEEE$imageurl");// Get data for this item

//           return Padding(
//             padding: const EdgeInsets.only(bottom: 20.0),
//             child: Column(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   height: 300.0,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 10,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: Image.network(
//                       '$baseUrl${imageurl}', // Change from 'image' to 'modelimage'
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Dress Name: ${dress["dressname"]}',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.teal,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Size: ${dress["size"]}',
//                   style: TextStyle(fontSize: 18, color: Colors.black54),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Color: ${dress["color"]}',
//                   style: TextStyle(fontSize: 18, color: Colors.black54),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   'Description: ${dress["description"]}',
//                   style: TextStyle(fontSize: 16, color: Colors.black54),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 16),
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                   decoration: BoxDecoration(
//                     color: Colors.teal,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Text(
//                     '₹ ${dress["price"]}',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     // Add your logic for purchase or other actions here
//                 //   },
//                 //   child: Text('Buy Now'),
//                 //   style: ElevatedButton.styleFrom(
//                 //     backgroundColor: Colors.orange,
//                 //     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                 //     shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadius.circular(30),
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }




import 'package:bridal_hub/presentation/user/book_artist.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:flutter/material.dart';

class DressDetailsPage extends StatelessWidget {
  final  String artistname;
  final String artistid;
  final List<Map<String, dynamic>> modelImages;  // Accept modelImages as parameter

  // Modify constructor to accept the modelImages list
  DressDetailsPage({required this.modelImages, required this.artistname, required this.artistid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dress Details'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: modelImages.length,  // Use the length of modelImages
        itemBuilder: (context, index) {
          final dress = modelImages[index];
          print(dress);
          final imageurl = dress['modelimage'];
          final  dressId = dress['id']; // Assuming each dress has a unique ID
          print("EEEEEEEE$imageurl"); // Get data for this item

          return Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 300.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      '$baseUrl$imageurl', // Change from 'image' to 'modelimage'
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Dress Name: ${dress["dressname"]}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Size: ${dress["size"]}',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                SizedBox(height: 8),
                Text(
                  'Color: ${dress["color"]}',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
                SizedBox(height: 8),
                Text(
                  'Description: ${dress["description"]}',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    '₹ ${dress["price"]}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the booking screen and pass the dress details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookArtistScreen(dressid: dressId, name: artistname,artistid: artistid,),
                      ),
                    );
                  },
                  child: Text('Book Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BookDressScreen extends StatelessWidget {
  final String dressId;

  // Constructor to accept dressId
  BookDressScreen({required this.dressId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Dress'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text('Booking details for Dress ID: $dressId'),
      ),
    );
  }
}
