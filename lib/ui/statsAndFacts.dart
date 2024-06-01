import 'package:flutter/material.dart';

class StatsAndFactsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List of stats and facts to display
    List<String> stats = [
      "🩸 Every two seconds, someone in the U.S needs blood.",
      "🩸 One donation can save up to three lives.",
      "🩸 Less than 10% of eligible donors actually donate blood each year."
    ];
    List<String> facts = [
      "🩸 The 'universal donor' blood type, O-negative, can be transfused to patients of any blood type, making it incredibly valuable in emergencies.",
      "🩸 Donating blood can help in reducing the risk of heart attacks and cancer, as it lowers iron levels in the body that can cause oxidative damage.",
      "🩸 Only about 7% of people in the U.S. have O-negative blood, highlighting the importance of donations from those with this rare blood type."
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Stats & Facts'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Aligns headers to the center
          children: <Widget>[
            Text(
              'Stats',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Centers the title text
            ),
            Divider(color: Colors.grey), // Adds a subtle divider under the title
            ...stats.map((stat) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Text(stat, style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            )).toList(),
            SizedBox(height: 30), // Adds more space between stats and facts
            Text(
              'Facts',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Centers the title text
            ),
            Divider(color: Colors.grey), // Adds a subtle divider under the title
            ...facts.map((fact) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
              child: Text(fact, style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            )).toList(),
          ],
        ),
      ),
    );
  }
}
