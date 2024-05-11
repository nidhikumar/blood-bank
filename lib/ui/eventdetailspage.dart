import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetailsPage extends StatelessWidget {
  final Map<String, dynamic> eventData;

  EventDetailsPage({required this.eventData});

  @override
  Widget build(BuildContext context) {
    DateTime eventDate = eventData['date'] is Timestamp ? (eventData['date'] as Timestamp).toDate() : DateTime.parse(eventData['date'] as String);
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(eventDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Title: ${eventData['title'] ?? 'No Title'}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Description: ${eventData['description'] ?? 'No Description'}'),
            SizedBox(height: 16),
            Text('Date: $formattedDate'),
          ],
        ),
      ),
    );
  }
}
