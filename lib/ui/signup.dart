import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

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

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

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
              if (_selectedAccountType == AccountType.donor) ...[
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
              if (_selectedAccountType == AccountType.hospital) ...[
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
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      await FirebaseFirestore.instance.collection('donor_list').add({
                        'email': emailController.text,
                        'name': nameController.text,
                        'age': int.parse(ageController.text),
                        'bloodGroup': bloodGroupController.text,
                        'phoneNumber': phoneNumberController.text,
                        'address': addressController.text,
                      });

                      Navigator.pop(context);
                    } else {
                      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      Position position = await _determinePosition();

                      await FirebaseFirestore.instance.collection('hospital_info').doc(user.user!.uid).set({
                        'email': emailController.text,
                        'phone_number': phoneNumberController.text,
                        'hospital_name': hospitalNameController.text,
                        'address': addressController.text,
                        'pin_code': pinCodeController.text,
                        'location': GeoPoint(position.latitude, position.longitude),
                      });

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
