// welcome.dart

import 'package:blood_bank/ui/previousDonations.dart';
import 'package:blood_bank/ui/statsAndFacts.dart';
import 'package:blood_bank/ui/updateProfile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'donate.dart';
import 'nearbyHospitals.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DonorLoginPage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Update Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateProfilePage()),
                );
              },
            ),
            ListTile(
              title: Text('See Nearby Hospitals'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NearbyHospitalsPage()),
                );
              },
            ),
            ListTile(
              title: Text('Stats & Facts'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatsAndFactsPage()),
                );
              },
            ),
            ListTile(
              title: Text('Previous Donations'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreviousDonationsPage()),
                );
              },
            ),
            ListTile(
              title: Text('Donate'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonationsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome!'),
      ),
    );
  }
}
