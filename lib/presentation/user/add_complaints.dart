import 'package:bridal_hub/presentation/user/homepage.dart';
import 'package:bridal_hub/services/loginApi.dart';
import 'package:bridal_hub/services/user/addcomplaintandpostreply.dart';
import 'package:flutter/material.dart';

class ComplaintScreen extends StatefulWidget {
  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _complaintController = TextEditingController();
  String? _selectedCategory;
  // final List<Map<String, String>> _complaints = [
   
  // ];

  void _submitComplaint()async {
    if (_complaintController.text.isEmpty || _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please complete all fields before submitting!")),
      );
      return;
    }

await sendComplaintApi({
  'complaint': _complaintController.text,
  'category': _selectedCategory,
  "userid":loginId

});
    // setState(() {
    //   _complaints.add({
    //     "complaint": _complaintController.text,
    //     "reply": "Pending response from admin.",
    //   });
    // });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Complaint submitted successfully!")),
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BridalEleganceHome(),));
    _complaintController.clear();
    _selectedCategory = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Complaint",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Complaint Section
            Text(
              "Add Complaint",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _complaintController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Enter your complaint",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent),
                ),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Select Complaint Category",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              value: _selectedCategory,
              items: [
                DropdownMenuItem(
                    value: "Service Issue", child: Text("Service Issue")),
                DropdownMenuItem(
                    value: "Payment Issue", child: Text("Payment Issue")),
                DropdownMenuItem(value: "Other", child: Text("Other")),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _submitComplaint,
                icon: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                label: Text(
                  "Submit Complaint",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            // View Replies Section
            // Text(
            //   "View Replies",
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black,
            //   ),
            // ),
            // SizedBox(height: 10),
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: _complaints.length,
            //   itemBuilder: (context, index) {
            //     final complaint = _complaints[index];
            //     return Card(
            //       elevation: 4,
            //       margin: EdgeInsets.only(bottom: 10),
            //       child: ListTile(
            //         title: Text(
            //           "Complaint: ${complaint['complaint']}",
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         ),
            //         subtitle: Text("Reply: ${complaint['reply']}"),
            //         leading: Icon(Icons.feedback, color: Colors.pinkAccent),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
