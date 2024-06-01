import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool isHospital = false; // Track whether the logged-in user is a hospital or not

  @override
  void initState() {
    super.initState();
    // Fetch the current user's details and populate the fields
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      emailController.text = currentUser.email ?? '';
      nameController.text = currentUser.displayName ?? '';
      // Determine if the logged-in user is a hospital
      FirebaseFirestore.instance.collection('hospital_info').doc(currentUser.uid).get().then((snapshot) {
        if (snapshot.exists) {
          setState(() {
            isHospital = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            if (!isHospital) // Display new password field for donors
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
              ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Current Password'),
              obscureText: true,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            if (!isHospital) // Display age field for donors
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
            if (!isHospital) // Display blood group field for donors
              TextField(
                controller: bloodGroupController,
                decoration: InputDecoration(labelText: 'Blood Group'),
              ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Update user's profile details in the database
                _updateProfile();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateProfile() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Update email if it's changed
        if (emailController.text != currentUser.email) {
          await currentUser.updateEmail(emailController.text);
        }
        // Update display name
        await currentUser.updateDisplayName(nameController.text);
        // Update password if a new one is provided
        if (newPasswordController.text.isNotEmpty) {
          await currentUser.updatePassword(newPasswordController.text);
        }
        // Update other profile details in the database
        if (isHospital) {
          // Update hospital-specific fields
          await FirebaseFirestore.instance.collection('hospital_info').doc(currentUser.uid).update({
            'phone_number': phoneNumberController.text,
          });
        } else {
          // Update donor-specific fields
          await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
            'age': int.parse(ageController.text),
            'blood_group': bloodGroupController.text,
            'phone_number': phoneNumberController.text,
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile updated successfully'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update profile: $e'),
        ),
      );
    }
  }
}
