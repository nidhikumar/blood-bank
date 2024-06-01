import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PreviousDonationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Donations'),
      ),
      body: DonationList(),
    );
  }
}

class DonationList extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _fetchDonations(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<QueryDocumentSnapshot> donations = snapshot.data!.docs;
          return ListView.builder(
            itemCount: donations.length,
            itemBuilder: (context, index) {
              var donation = donations[index];
              return DonationCard(
                amount: donation['amount'].toDouble(), // Convert to double
                date: donation['date'].toDate(),
              );
            },
          );
        }
      },
    );
  }

  Stream<QuerySnapshot> _fetchDonations() {
    User? user = _auth.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('donations')
          .where('email', isEqualTo: user.email)
          // .orderBy('date', descending: true)
          .snapshots();
    } else {
      throw Exception('User not logged in');
    }
  }
}

class DonationCard extends StatelessWidget {
  final double amount;
  final DateTime date; // Define 'date' parameter

  DonationCard({required this.amount, required this.date}); // Include 'date' parameter in the constructor

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text('Amount: $amount'),
        subtitle: Text('Date: ${date.toString()}'), // Display date
      ),
    );
  }
}
