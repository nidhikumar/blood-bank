import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

class FindNearbyHospital extends StatefulWidget {
  @override
  _FindNearbyHospitalState createState() => _FindNearbyHospitalState();
}

class HospitalCard extends StatelessWidget {
  final String hospitalName;
  final String address;
  final String email;
  final GeoPoint location;

  // Constructor
  HospitalCard({
    Key? key,
    required this.hospitalName,
    required this.address,
    required this.email,
    required this.location,
  }) : super(key: key);

  void _launchMaps() async {
    final Uri mapsUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}',
    );
    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri);
    } else {
      print('Could not launch $mapsUri');
    }
  }

  void _launchEmail(String toEmail) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: toEmail,
      query: 'subject=Hospital Inquiry',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Unable to launch the email app.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use a column to layout the card contents.
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Hospital details in the center.
            Text(
              hospitalName,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            Text(
              address,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 16),
            // Row for map and contact icons.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.location_pin), // This uses a built-in map icon
                  onPressed: _launchMaps,
                ),
                // Email button.
                IconButton(
                  icon: Icon(Icons.email),
                  onPressed: () => _launchEmail(email),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FindNearbyHospitalState extends State<FindNearbyHospital> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> hospitals = [];
  bool isLoading = true;
  String errorMessage = '';
  Position? userLocation;

  @override
  void initState() {
    super.initState();
    _determinePosition().then((_) {
      // After location is fetched, get the hospitals
      getNearbyHospitals().then((_) {
        setState(() {
          isLoading = false; // Data fetch is complete, stop showing loading indicator
        });
      }).catchError((error) {
        setState(() {
          isLoading = false;
          errorMessage = error.toString();
        });
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });
    });
  }

 Future<void> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled, cannot get position.
    setState(() {
      errorMessage = 'Location services are disabled.';
    });
    return;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try requesting permissions again.
      setState(() {
        errorMessage = 'Location permissions are denied';
      });
      return;
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    setState(() {
      errorMessage = 'Location permissions are permanently denied';
    });
    return;
  }

  // When we reach here, permissions are granted and we can continue accessing the position of the device.
  Position position = await Geolocator.getCurrentPosition();
  userLocation = position;

  // Log the position
  print('Current Position: ${position.latitude}, ${position.longitude}');

  setState(() {
    errorMessage = ''; // Clear any previous error messages.
  });
}



 Future<void> getNearbyHospitals() async {
  if (userLocation == null) {
    setState(() {
      isLoading = false;
      errorMessage = 'User location is not available.';
    });
    return;
  }

  // Define the range for latitude and longitude you consider "nearby"
  double rangeLat = 5 / 69;
  double latitude = userLocation!.latitude;
  double longitude = userLocation!.longitude;
  // Convert latitude from degrees to radians for the cosine calculation
  double latitudeInRadians = latitude * (pi / 180);
  // Earth's radius in miles is approximately 3959
  double milesPerDegreeLongitude = cos(latitudeInRadians) * 3959 * (pi / 180);

  // For a 5 mile radius, you need to adjust the rangeLon based on the latitude
  double rangeLon = 5 / milesPerDegreeLongitude;

  var hospitalQuery = firestore.collection('hospital_info')
    .where('location', isGreaterThanOrEqualTo: GeoPoint(latitude - rangeLat, longitude - rangeLon))
    .where('location', isLessThanOrEqualTo: GeoPoint(latitude + rangeLat, longitude + rangeLon));

  try {
    var querySnapshot = await hospitalQuery.get();
    setState(() {
      hospitals = querySnapshot.docs;
      isLoading = false;
    });
  } catch (e) {
    setState(() {
      isLoading = false;
      errorMessage = e.toString();
    });
  }
}



 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Nearby Hospitals'),
      // If you need more space inside the AppBar, you can adjust the titleSpacing property.
    ),
    body: isLoading
        ? Center(child: CircularProgressIndicator())
        : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage))
            : Column( // Use Column to control the layout of AppBar and List
                children: [
                  SizedBox(height: 20), // Add space below the AppBar
                  Expanded( // Wrap the ListView.builder with Expanded
                    child: ListView.builder(
                      itemCount: hospitals.length,
                      itemBuilder: (context, index) {
                        var hospitalData = hospitals[index].data() as Map<String, dynamic>;
                        String hospitalName = hospitalData['hospital_name'] ?? 'Unknown Hospital';
                        GeoPoint location = hospitalData['location'];
                        String address = hospitalData['address'] ?? 'No address provided';
                        String email = hospitalData['email'] ?? 'info@hospital.com'; // Add a default email or retrieve from data

                        return HospitalCard(
                          hospitalName: hospitalName,
                          address: address,
                          email: email,
                          location: location,
                        );
                      },
                    ),
                  ),
                ],
              ),
  );
}
}