import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virica/self_defence.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDFB6B2),
      appBar: AppBar(
        backgroundColor: Color(0xFF190019),
        title: Text(
          "Virica",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w400,
            color: Color(0xFFDFB6B2),
            fontFamily: 'Samarkan',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Implement your logout logic here
              // For example, you can clear user authentication and navigate to the login screen
              Navigator.pushReplacementNamed(context, '/signin');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            children: [
              // Features
              _buildFeatureContainer(Icons.safety_check_sharp, 'Self Defence Tutorials',
                  '/self_defence'),
              _buildFeatureContainer(Icons.security, 'Safety Toolkit', '/safetykit'),
              _buildFeatureContainer(Icons.location_on, 'Locate You', 'https://rohitb0304.github.io/locate'),
              _buildFeatureContainer(Icons.place, 'Safety Zones Near Me', 'https://rohitb0304.github.io/locate'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Color(0xFF190019),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                // Navigate to homepage
                Navigator.pushNamed(context, '/homepage');
              },
            ),
            IconButton(
              icon: Icon(Icons.map, color: Colors.white),
              onPressed: () {
                // Navigate to map page
              },
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(10, 255, 255, 255),
              ),
              child: IconButton(
                icon: Icon(Icons.numbers_outlined, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/helpline');
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                // Navigate to settings page
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _callSOS,
        tooltip: 'SOS',
        child: Icon(Icons.sos, color: Colors.red[700], size: 50),
      ),
    );
  }

  Widget _buildFeatureContainer(IconData icon, String text, String route) {
    return SingleChildScrollView(
      child: Container(
        width: 300, // Custom width
        height: 140, // Custom height
        margin: EdgeInsets.all(10), // Custom margin
        decoration: BoxDecoration(
          color: Color(0xFF336699), // Custom background color
          borderRadius: BorderRadius.circular(100), // Custom border radius
        ),
        child: _buildFeatureTile(icon, text, route),
      ),
    );
  }

  Widget _buildFeatureTile(IconData icon, String text, String route) {
    return ElevatedButton(
      onPressed: () {
        // Implement action for each feature
        if (route.startsWith('http')) {
          // If the route starts with 'http', launch a URL
          _launchURL(route);
        } else {
          // If it's a route, navigate to it
          if (route == '/safetykit') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SelfDefence()));
          } else {
            Navigator.pushNamed(context, route);
          }
        }
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent, // Transparent background
        onPrimary: Colors.white, // Text color
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50),
          SizedBox(height: 20),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _callSOS() {
    launch('tel:112');
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the error
    }
  }
}
