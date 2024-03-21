import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addEmergencyContacts(String userId, List<Contact> contacts) async {
    List<Map<String, dynamic>> contactsData = contacts.map((contact) {
      return {
        'givenName': contact.givenName,
        'familyName': contact.familyName,
        'phoneNumber': contact.phones?.first.value,
        'city': contact.postalAddresses?.first?.city,
        // Add other fields as needed
      };
    }).toList();

    await _firestore.collection('users').doc(userId).collection('emergencyContacts').add({
      'contacts': contactsData,
    });
  }

  Future<List<Contact>> getEmergencyContacts(String userId) async {
    var snapshot = await _firestore.collection('users').doc(userId).collection('emergencyContacts').get();

    List<Contact> contacts = [];
    for (var doc in snapshot.docs) {
      var data = doc.data() as Map<String, dynamic>;
      List<Map<String, dynamic>> contactsData = data['contacts'];
      contacts.addAll(contactsData.map((contactData) {
        return Contact(
          givenName: contactData['givenName'],
          familyName: contactData['familyName'],
          phones: [Item(label: 'mobile', value: contactData['phoneNumber'])],
          postalAddresses: [
            PostalAddress(city: contactData['city']),
          ],
          // Add other fields as needed
        );
      }));
    }

    return contacts;
  }
}
