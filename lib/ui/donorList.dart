import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'displayevents.dart';
import 'donate.dart';
import 'hospital_addevents.dart';
import 'login.dart';
import 'previousDonations.dart'; // Import PreviousDonationsPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Donation App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: DonorListScreen(),
    );
  }
}

class Donor {
  final String name;
  final String email;
  final String phoneNumber;
  final String bloodGroup;
  final String address;

  Donor({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.bloodGroup,
    required this.address,
  });

  factory Donor.fromMap(Map<String, dynamic> map) {
    return Donor(
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      bloodGroup: map['bloodGroup'],
      address: map['address'],
    );
  }
}

class DonorListScreen extends StatefulWidget {
  @override
  _DonorListScreenState createState() => _DonorListScreenState();
}

class _DonorListScreenState extends State<DonorListScreen> {
  late Stream<QuerySnapshot> donorStream;
  String selectedBloodGroup = 'All';

  @override
  void initState() {
    super.initState();
    // Initialize the Firestore stream for the donor_list collection
    donorStream = FirebaseFirestore.instance.collection('donor_list').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor List'),
        actions: [
          // Blood group filter dropdown
          DropdownButton<String>(
            value: selectedBloodGroup,
            items: [
              'All', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
            ].map((bloodGroup) => DropdownMenuItem(
              value: bloodGroup,
              child: Text(bloodGroup),
            )).toList(),
            onChanged: (value) {
              setState(() {
                selectedBloodGroup = value!;
              });
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
              title: Text('Request Blood Donation'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequestBloodDonationScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Add Hospital Events'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HospitalAddEventsPage()),
                );
              },
            ),
            ListTile(
              title: Text('Hospital Events'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DisplayEventsPage()),
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
                  MaterialPageRoute(builder: (context) => DonationsPage(source: DonationSource.Hospital)),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DonorLoginPage()),
                );
              },
            ),
            // Add more ListTile widgets for other sidebar items
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: donorStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator while waiting for data
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            // Handle error
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Parse the donors data from the snapshot
          List<Donor> donors = snapshot.data!.docs.map((doc) {
            return Donor.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          // Filter the donors based on the selected blood group
          List<Donor> filteredDonors = filterDonors(donors);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: filteredDonors.length,
                  itemBuilder: (context, index) {
                    final donor = filteredDonors[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name: ${donor.name}', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('Email: ${donor.email}'),
                            Text('Phone: ${donor.phoneNumber}'),
                            Text('Blood Group: ${donor.bloodGroup}'),
                            Text('Address: ${donor.address}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the RequestBloodDonationScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RequestBloodDonationScreen()),
                  );
                },
                child: Text('Request Blood Donations'),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Donor> filterDonors(List<Donor> donors) {
    if (selectedBloodGroup == 'All') {
      return donors;
    } else {
      return donors.where((donor) => donor.bloodGroup == selectedBloodGroup).toList();
    }
  }
}

class RequestBloodDonationScreen extends StatefulWidget {
  @override
  _RequestBloodDonationScreenState createState() => _RequestBloodDonationScreenState();
}

class _RequestBloodDonationScreenState extends State<RequestBloodDonationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _bloodGroup = 'A+'; // Set a valid default value
  String _quantity = '';
  String _additionalInfo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Blood Donation'),
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
              title: Text('Donor List'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to the DonorListScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorListScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Add Hospital Events'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HospitalAddEventsPage()),
                );
              },
            ),
            ListTile(
              title: Text('Hospital Events'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DisplayEventsPage()),
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
                  MaterialPageRoute(builder: (context) => DonationsPage(source: DonationSource.Donor)),
                );
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DonorLoginPage()),
                );
              },
            ),
            // Add more ListTile widgets for other sidebar items
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: _bloodGroup,
                items: [
                  'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
                ].map((bloodGroup) => DropdownMenuItem(
                  value: bloodGroup,
                  child: Text(bloodGroup),
                )).toList(),
                onChanged: (value) {
                  setState(() {
                    _bloodGroup = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Blood Group'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a blood group';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantity'),
                onChanged: (value) {
                  _quantity = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Additional Information'),
                onChanged: (value) {
                  _additionalInfo = value;
                },
                validator: (value) {
                  // Optional field, no validation needed
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // The form is valid, proceed with submission
                    try {
                      // Create a reference to the Firestore collection 'donation_requests'
                      CollectionReference donationRequests = FirebaseFirestore.instance.collection('donation_requests');

                      // Add a new document to the collection with the form data
                      await donationRequests.add({
                        'bloodGroup': _bloodGroup,
                        'quantity': _quantity,
                        'additionalInfo': _additionalInfo,
                        'timestamp': FieldValue.serverTimestamp(), // Optional: Add a timestamp to track when the request was made
                      });

                      // Show a success message to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Blood donation request submitted!')),
                      );

                      // Optionally, navigate back to the previous screen
                      Navigator.pop(context);
                    } catch (e) {
                      // Handle errors that may occur during data submission
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: Could not submit request')),
                      );
                      print('Error submitting request: $e');
                    }
                  }
                },
                child: Text('Submit Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}