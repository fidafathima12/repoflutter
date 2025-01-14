import 'package:flutter/material.dart';

class Notifi extends StatelessWidget {
  const Notifi({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 18, 175, 196),
          title: Text(
            'Notification',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                elevation: 4,
                child: ListTile(
                  title: Text(
                    'Notification1',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Notification1'),
                  trailing: Text(
                    '4/sep/2024',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Center(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                elevation: 4,
                child: ListTile(
                  title: Text(
                    'Notification2',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Notification2'),
                  trailing: Text(
                    '10/sep/2024',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {},
                ),
              ),
            ),
            Center(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                elevation: 4,
                child: ListTile(
                  title: Text(
                    'Notification3',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Notification3'),
                  trailing: Text(
                    '4/oct/2024',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ],
        ));
  }
}
