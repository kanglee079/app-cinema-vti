import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedCity = "Ho Chi Minh City";
  final List<String> _cities = [
    "Ho Chi Minh City",
    "Hanoi",
    "Da Nang",
    "Can Tho",
    "Hue"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Information')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // ... Your other InfoRow widgets ...
          InfoRow(
            title: 'City',
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey
                      .withOpacity(0.5), // Adjust the opacity as needed
                ),
                color: Colors.white, // Dropdown background color
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCity,
                  icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCity = newValue!;
                    });
                  },
                  items: _cities.map<DropdownMenuItem<String>>((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  isExpanded: true,
                ),
              ),
            ),
          ),
          // ... Your other InfoRow widgets ...
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final Widget child;

  const InfoRow({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(width: 8), // Spacing between title and dropdown
        Expanded(child: child),
      ],
    );
  }
}
