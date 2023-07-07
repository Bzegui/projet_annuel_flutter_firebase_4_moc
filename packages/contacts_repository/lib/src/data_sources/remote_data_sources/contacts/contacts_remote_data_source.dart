import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import '../../../../contacts_repository_exports.dart';

/// {@template contacts remote data source}
/// Contacts remote data source
/// {@endtemplate}

@immutable
sealed class ContactsRemoteDataSource {}

final class ContactsDataSource extends ContactsRemoteDataSource {

  final CollectionReference _contactCollection = FirebaseFirestore
      .instance.collection('contacts');

  /// {@macro getContactById}
  /// use Streams to return a contact (list of unique contact) if contactId
  /// matched on database or an empty contacts list if database snapshot is
  /// empty.
  /// use 'asyncExpand' to transform each element of the initial stream to a new
  /// one. if database snapshot isn't empty, the list of matching contacts with
  /// provided id is returned, otherwise, an empty list of contacts is returned.
  Stream<List<Contact>> getContactById(String contactId) {
    try {
      return _contactCollection
          .where('contactId', isEqualTo: contactId)
          .snapshots()
          .asyncExpand((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          return Stream.value(snapshot.docs.map((doc) {
            debugPrint("${doc.data()}");
            return Contact.fromFirestore(doc.data() as Map<String, dynamic>,
                doc.id);
          }).toList());
        } else {
          return Stream.value(<Contact>[]);
        }
      });
    } catch (error) {
      throw Exception('Failed to get contacts');
    }
  }
}

