import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum AccountType { donor, hospital }

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  AccountType _selectedAccountType = AccountType.donor; // Default to donor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButtonFormField<AccountType>(
                value: _selectedAccountType,
                items: [
                  DropdownMenuItem(
                    value: AccountType.donor,
                    child: Text('Donor'),
                  ),
                  DropdownMenuItem(
                    value: AccountType.hospital,
                    child: Text('Hospital'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedAccountType = value!;
                  });
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              if (_selectedAccountType == AccountType.donor) // Show additional fields for donor signup
                ...[
                  SizedBox(height: 10),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: ageController,
                    decoration: InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: bloodGroupController,
                    decoration: InputDecoration(labelText: 'Blood Group'),
                  ),
                ],
              SizedBox(height: 10),
              TextField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
              ),
              if (_selectedAccountType == AccountType.hospital) // Show additional fields for hospital signup
                ...[
                  SizedBox(height: 10),
                  TextField(
                    controller: hospitalNameController,
                    decoration: InputDecoration(labelText: 'Hospital Name'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(labelText: 'Address'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: pinCodeController,
                    decoration: InputDecoration(labelText: 'Pin Code'),
                  ),
                ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    if (_selectedAccountType == AccountType.donor) {
                      // Implement donor signup logic
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      // Save donor info to Firestore
                      await FirebaseFirestore.instance.collection('donor_list').add({
                        'email': emailController.text,
                        'name': nameController.text,
                        'age': int.parse(ageController.text),
                        'bloodGroup': bloodGroupController.text,
                        'phoneNumber': phoneNumberController.text,
                        'address': addressController.text,
                      });

                      // Navigate to login page after successful signup
                      Navigator.pop(context);
                    } else {
                      // Implement hospital signup logic
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      // Save hospital info to Firestore
                      await FirebaseFirestore.instance.collection('hospital_info').add({
                        'email': emailController.text,
                        'phone_number': phoneNumberController.text,
                        'hospital_name': hospitalNameController.text,
                        'address': addressController.text,
                        'pin_code': pinCodeController.text,
                      });

                      // Navigate to login page after successful signup
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
