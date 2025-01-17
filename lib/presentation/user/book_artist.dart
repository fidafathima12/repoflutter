// import 'package:bridal_hub/presentation/user/paymentscreen.dart';
// import 'package:flutter/material.dart';

// class BookArtistScreen extends StatefulWidget {
//   @override
//   _BookArtistScreenState createState() => _BookArtistScreenState();
// }

// class _BookArtistScreenState extends State<BookArtistScreen> {
//   DateTime? selectedDate;
//   TimeOfDay? selectedTime;
//   TextEditingController _locationController=TextEditingController();
//   String? selecetdValue;

//   Future<void> pickDate() async {
//     final DateTime? date = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//     if (date != null) {
//       setState(() {
//         selectedDate = date;
//       });
//     }
//   }

//   Future<void> pickTime() async {
//     final TimeOfDay? time = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (time != null) {
//       setState(() {
//         selectedTime = time;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Book an Artist",
//           style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white60),
//         ),
//         backgroundColor: Colors.blue[900],
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Artist Information
//             // Card(
//             //   elevation: 5,
//             //   shape: RoundedRectangleBorder(
//             //     borderRadius: BorderRadius.circular(15),
//             //   ),
//             //   child: ListTile(
//             //     leading: CircleAvatar(
//             //       radius: 30,
//             //       backgroundImage: NetworkImage(
//             //           'https://via.placeholder.com/150'), // Replace with artist image
//             //     ),
//             //     title: Text(
//             //       "Sophia Johnson",
//             //       style: TextStyle(
//             //           fontWeight: FontWeight.bold, fontSize: 18),
//             //     ),
//             //     subtitle: Text("Bridal Makeup Specialist | ★ 4.8"),
//             //   ),
//             // ),
//             SizedBox(height: 20),
//             // Service Dropdown
//             Text(
//               "Select Service",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               items: [
//                 DropdownMenuItem(
//                   value: "Makeup",
//                   child: Text("Makeup"),
//                 ),
//                 DropdownMenuItem(
//                   value: "Photography",
//                   child: Text("Photography"),
//                 ),
//                 DropdownMenuItem(
//                   value: "Mehandi ",
//                   child: Text("Hair Styling"),
//                 ),
//                 DropdownMenuItem(
//                   value: " personal assistant",
//                   child: Text("personal assistant"),
//                 ),
//               ],
//               onChanged: (value) {},
//               hint: Text("Select Service"),
//             ),
//             SizedBox(height: 20),
//             // Date Picker
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: pickDate,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue[900],
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text(selectedDate == null
//                         ? "Pick Date"
//                         : "Date: ${selectedDate!.toLocal()}".split(' ')[0],style: TextStyle(color:Colors.white70 ),),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 // Expanded(
//                 //   child: ElevatedButton(
//                 //     onPressed: pickTime,
//                 //     style: ElevatedButton.styleFrom(
//                 //       backgroundColor: Colors.blue[900],
//                 //       shape: RoundedRectangleBorder(
//                 //         borderRadius: BorderRadius.circular(10),
//                 //       ),
//                 //     ),
//                 //     child: Text(selectedTime == null
//                 //         ? "Pick Time"
//                 //         : "Time: ${selectedTime!.format(context)}",style: TextStyle(color:Colors.white70 )),
//                 //   ),
//                 // ),
//               ],
//             ),
//             SizedBox(height: 20),
//             // Event Location
//             Text(
//               "Event Location",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: _locationController,
//               decoration: InputDecoration(
//                 hintText: "Enter event address",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             // Confirm Booking Button
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => PaymentScreen(
//                           artisname: '',
//                               artisid: '',
//                               selectedDate: selectedDate!,
//                               selectedTime: '',
//                                service: '',
                               
//                             )),
//                   );
//                   // Add booking logic here
//                 },
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                   backgroundColor: Colors.blue[900],
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 child: Text(
//                   "Confirm Booking",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:bridal_hub/presentation/user/paymentscreen.dart';
import 'package:flutter/material.dart';

class BookArtistScreen extends StatefulWidget {
  final String name;
  final String artistid;

  const BookArtistScreen({super.key, required this.name, required this.artistid});
  @override
  _BookArtistScreenState createState() => _BookArtistScreenState();
}

class _BookArtistScreenState extends State<BookArtistScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController _locationController = TextEditingController();
  String? selectedService;  

  Future<void> pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> pickTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book an Artist",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white60),
        ),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Service Dropdown
            Text(
              "Select Service",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: "Makeup",
                  child: Text("Makeup"),
                ), DropdownMenuItem(
                  value: "Mehandi",
                  child: Text("Mehandi"),
                ),
                DropdownMenuItem(
                  value: "Photography",
                  child: Text("Photography"),
                ),
                DropdownMenuItem(
                  value: "Hair Styling",
                  child: Text("Hair Styling"),
                ),
                DropdownMenuItem(
                  value: "Personal Assistant",
                  child: Text("Personal Assistant"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedService = value;
                });
              },
              hint: Text("Select Service"),
            ),
            SizedBox(height: 20),
            // Date Picker
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: pickDate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      selectedDate == null
                          ? "Pick Date"
                          : "Date: ${selectedDate!.toLocal()}".split(' ')[0],
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 20),
            // Event Location
            Text(
              "Event Location",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: "Enter event address",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Confirm Booking Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Check if a service is selected
                  if (selectedService != null && selectedDate != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                          artisname: widget.name,
                          userid: widget.artistid, 
                          selectedDate: selectedDate!, 
                          selectedTime: selectedTime?.format(context) ?? '', 
                          service: selectedService!, 
                          artisid: widget.artistid.toString(),
                          location:_locationController.text,
                        ),
                      ),
                      
                    );
                  } else {
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please select a service and date."),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  "Confirm Booking",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
