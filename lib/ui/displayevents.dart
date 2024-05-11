import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'eventdetailspage.dart';

class DisplayEventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The current time, used to filter out past events
    Timestamp now = Timestamp.fromDate(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('Display Events'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('hospitalEvents')
            .where('date', isGreaterThanOrEqualTo: now) // Only fetch future events
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
              DateTime eventDate = data['date'] is Timestamp ? (data['date'] as Timestamp).toDate() : DateTime.parse(data['date']);
              String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(eventDate);

              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: Icon(Icons.event),
                  title: Text(data['title'] ?? 'No Title'),
                  subtitle: Text(data['description'] ?? 'No Description'),
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
