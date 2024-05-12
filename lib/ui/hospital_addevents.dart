import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalAddEventsPage extends StatefulWidget {
  @override
  _HospitalAddEventsPageState createState() => _HospitalAddEventsPageState();
}

class _HospitalAddEventsPageState extends State<HospitalAddEventsPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  String? selectedCategory;
  final List<String> categories=['Event', 'Emergency'];

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (pickedTime != null && pickedTime != startTime) {
      setState(() {
        startTime = pickedTime;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (pickedTime != null && pickedTime != endTime) {
      setState(() {
        endTime = pickedTime;
      });
    }
  }

  DateTime combineDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.jm(); // using AM/PM format
    return format.format(dt);
  }

  Future<void> addEventToFirestore() async {
    try {
      CollectionReference events = FirebaseFirestore.instance.collection('hospitalEvents');
      await events.add({
        'title': titleController.text.trim(),
        'description': descriptionController.text.trim(),
        'location': locationController.text.trim(),
        'date': Timestamp.fromDate(selectedDate),
        'startTime': Timestamp.fromDate(combineDateTime(selectedDate, startTime)),
        'endTime': Timestamp.fromDate(combineDateTime(selectedDate, endTime)),
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Event added successfully!'))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add event: ${e.toString()}'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Hospital Event'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Event Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              hint: Text('Select Category'),
              items: categories.map
                ( (String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (picked != null && picked != selectedDate) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(text: "${selectedDate.toLocal()}".split(' ')[0]),
                  decoration: InputDecoration(labelText: 'Event Date'),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _selectStartTime(context),
                  child: Text('Select Start Time'),
                ),
                Text('Start Time: ${formatTimeOfDay(startTime)}'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _selectEndTime(context),
                  child: Text('Select End Time'),
                ),
                Text('End Time: ${formatTimeOfDay(endTime)}'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty || descriptionController.text.isEmpty || locationController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('All fields are required'))
                  );
                } else {
                  addEventToFirestore(); // Call the function to save data to Firestore
                }
              },

              child: Text('Add Event'),
            ),
          ],
        ),
      ),
    );
  }
}