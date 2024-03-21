import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:virica/firebase_service.dart';

class EmergencyContacts extends StatefulWidget {
  const EmergencyContacts({Key? key}) : super(key: key);

  @override
  State<EmergencyContacts> createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  List<Contact> selectedContacts = [];
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
        backgroundColor: Color(0xFFfbe4d8), // Match the background color of LoginsScreen
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to SOS Homepage
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedContacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(selectedContacts[index].displayName ?? ''),
                  subtitle: Text(selectedContacts[index].phones?.first.value ?? ''),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _callContact(selectedContacts[index].phones?.first.value ?? '');
                    },
                    child: Text('Call'),
                  ),
                );
              },
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(labelText: 'First Name'),
                  ),
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(labelText: 'Last Name'),
                  ),
                  TextField(
                    controller: mobileNumberController,
                    decoration: InputDecoration(labelText: 'Mobile Number'),
                  ),
                  TextField(
                    controller: cityController,
                    decoration: InputDecoration(labelText: 'City'),
                  ),
                  TextField(
                    controller: relationController,
                    decoration: InputDecoration(labelText: 'Relation'),
                  ),
                  TextField(
                    controller: ageController,
                    decoration: InputDecoration(labelText: 'Age'),
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addManualContact();
                    },
                    child: Text('Add Contact'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String userId = getCurrentUserId(); // Replace with your logic to get the user ID

          // Open phonebook and select contacts
          Iterable<Contact> contactsIterable = await ContactsService.getContacts();
          
          // Convert Iterable<Contact> to List<Contact>
          List<Contact> contacts = contactsIterable.toList();

          // Add selected contacts to the Firestore database
          await FirebaseService().addEmergencyContacts(userId, contacts);

          // Update the local state with selected contacts
          setState(() {
            selectedContacts.addAll(contacts);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
  String getCurrentUserId() {
    // Replace this with your actual logic to get the user ID
    // For Firebase Authentication:
    return FirebaseAuth.instance.currentUser!.uid;
  }

  void _addManualContact() {
    if (_validateInputs()) {
      // Create a manual contact and add it to the list
      Contact manualContact = Contact(
        givenName: firstNameController.text,
        familyName: lastNameController.text,
        phones: [Item(label: 'mobile', value: mobileNumberController.text)],
        postalAddresses: [
          PostalAddress(
            city: cityController.text,
          ),
        ],
      );

      // You can add more details to manualContact using other controllers

      setState(() {
        selectedContacts.add(manualContact);

        // Clear the text controllers
        firstNameController.clear();
        lastNameController.clear();
        mobileNumberController.clear();
        cityController.clear();
        relationController.clear();
        ageController.clear();
      });
    }
  }

  bool _validateInputs() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        mobileNumberController.text.isEmpty ||
        cityController.text.isEmpty ||
        relationController.text.isEmpty ||
        ageController.text.isEmpty) {
      _showValidationError('All fields are required');
      return false;
    }

    if (!RegExp(r'^[a-zA-Z]+$').hasMatch(firstNameController.text) ||
        !RegExp(r'^[a-zA-Z]+$').hasMatch(lastNameController.text)) {
      _showValidationError('Name should contain only alphabets');
      return false;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(mobileNumberController.text)) {
      _showValidationError('Mobile number should contain only numbers');
      return false;
    }

    int age = int.tryParse(ageController.text) ?? 0;
    if (age < 18 || age > 100) {
      _showValidationError('Age should be between 18 and 100');
      return false;
    }

    return true;
  }

  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _callContact(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the error
    }
  }
}
