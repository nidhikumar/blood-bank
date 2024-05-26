import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'eventdetailspage.dart';

class DonorHomePage extends StatelessWidget {
  final String donorBloodGroup;

  DonorHomePage({required this.donorBloodGroup});

  @override
  Widget build(BuildContext context) {
    // The current time, used to filter out past events
    Timestamp now = Timestamp.fromDate(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Blood Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('donation_requests')
            .where('bloodGroup', isEqualTo: donorBloodGroup) // Filter by blood group
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No events found'));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

              // Retrieve and format the event date
              DateTime eventDate = data['timestamp'] is Timestamp ? (data['timestamp'] as Timestamp).toDate() : DateTime.parse(data['timestamp']);
              String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(eventDate);

              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: Icon(Icons.event),
                  title: Text(data['eventName'] ?? 'No Title'), // Assuming you have an event name
                  subtitle: Text(data['bloodGroup']),
                  trailing: Text(formattedDate),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailsPage(eventData: data),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
