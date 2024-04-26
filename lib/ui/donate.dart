import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonationsPage extends StatefulWidget {
  @override
  _DonationsPageState createState() => _DonationsPageState();
}

class _DonationsPageState extends State<DonationsPage> {
  final TextEditingController amountController = TextEditingController();
  bool isValidAmount = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(), // Box-like appearance
                errorText: isValidAmount ? null : 'Please enter a valid amount', // Error message
              ),
              onChanged: (value) {
                // Validate input and update state
                setState(() {
                  isValidAmount = _validateAmount(value);
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isValidAmount ? () async {
                // Donation logic
                await donate();
              } : null, // Disable button if input is invalid
              child: Text('Donate'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateAmount(String value) {
    // Check if the value is empty or contains non-numeric characters
    if (value.isEmpty || double.tryParse(value) == null) {
      return false;
    }
    return true;
  }

  Future<void> donate() async {
    try {
      // Validate input again before donation
      if (!_validateAmount(amountController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid amount'),
          ),
        );
        return;
      }

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Fetch user data from Firestore
        var userSnapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        var userName = userSnapshot['name'];

        // Prepare donation data
        var donationData = {
          'email': user.email,
          'amount': double.parse(amountController.text),
          'date': Timestamp.now(),
        };

        // Add donation to Firestore collection
        await FirebaseFirestore.instance.collection('donations').add(donationData);

        // Clear amount field
        amountController.clear();

        // Show donation success modal
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Thank you for donating'),
              content: Text('Thank you for donating us $userName'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      } else {
        // Show error message if user is not logged in
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User not logged in'),
          ),
        );
      }
    } catch (e) {
      // Show error message if donation fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to donate: $e'),
        ),
      );
    }
  }
}