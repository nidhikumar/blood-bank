import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donor List',
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
}

class DonorListScreen extends StatefulWidget {
  @override
  _DonorListScreenState createState() => _DonorListScreenState();
}

class _DonorListScreenState extends State<DonorListScreen> {
  List<Donor> donors = [
    Donor(name: 'Ruturaj', email: 'rg@gmail.com', phoneNumber: '123-456-7890', bloodGroup: 'A+', address: 'Bothell'),
    Donor(name: 'Rachin', email: 'rachin@gmail.com', phoneNumber: '234-567-8901', bloodGroup: 'O-', address: 'bothell'),
    Donor(name: 'Dube', email: 'dube@gmail.com', phoneNumber: '234-567-8901', bloodGroup: 'O+', address: 'bothell'),
    Donor(name: 'Ruturaj', email: 'rg@gmail.com', phoneNumber: '123-456-7890', bloodGroup: 'A+', address: 'Bothell'),
    Donor(name: 'Rachin', email: 'rachin@gmail.com', phoneNumber: '234-567-8901', bloodGroup: 'O-', address: 'bothell'),
    Donor(name: 'Dube', email: 'dube@gmail.com', phoneNumber: '234-567-8901', bloodGroup: 'O+', address: 'bothell'),
    Donor(name: 'Ruturaj', email: 'rg@gmail.com', phoneNumber: '123-456-7890', bloodGroup: 'A+', address: 'Bothell'),
    Donor(name: 'Rachin', email: 'rachin@gmail.com', phoneNumber: '234-567-8901', bloodGroup: 'O-', address: 'bothell'),
    Donor(name: 'Dube', email: 'dube@gmail.com', phoneNumber: '234-567-8901', bloodGroup: 'O+', address: 'bothell'),
    // Add more donors as needed
  ];

  String selectedBloodGroup = 'All';

  @override
  Widget build(BuildContext context) {
    List<Donor> filteredDonors = filterDonors();

    return Scaffold(
      appBar: AppBar(
        title: Text('Donor List'),
        actions: [
          DropdownButton<String>(
            value: selectedBloodGroup,
            items: ['All', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                .map((bloodGroup) => DropdownMenuItem(
              value: bloodGroup,
              child: Text(bloodGroup),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedBloodGroup = value!;
              });
            },
          ),
        ],
      ),
      body: Column(
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
      ),
    );
  }

  List<Donor> filterDonors() {
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle the request submission logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Blood donation request submitted!')),
                    );
                    // Optionally, navigate back to the previous screen
                    Navigator.pop(context);
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
