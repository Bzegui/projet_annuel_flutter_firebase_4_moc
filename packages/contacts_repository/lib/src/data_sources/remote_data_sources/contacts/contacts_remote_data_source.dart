import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../../../../contacts_repository_exports.dart';

@immutable
sealed class ContactsRemoteDataSource {}

final class ContactsDataSource extends ContactsRemoteDataSource {

  final CollectionReference _contactCollection = FirebaseFirestore
      .instance.collection('contacts');

  Future<List<Contact>> getContactById(String contactId) async {
    try {
      QuerySnapshot snapshot = await _contactCollection
          .where('contact_id', isEqualTo: contactId)
          .get();

      return snapshot.docs.map((doc) {
        return Contact.fromFirestore(doc.data() as Map<String, dynamic>,
            doc.id);
      }).toList();

    } catch (error) {

      rethrow;
    }
  }
}

