import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'logs';

  // Get all transactions without any filters
  Future<List<Map<String, dynamic>>> getTransactions(String uid) async {
    try {
      final transactions = await _firestore
          .collection(collectionName)
          .where('uid', isEqualTo: uid)
          .orderBy('timestamp', descending: true)
          .get();

      final List<Map<String, dynamic>> transactionsList = [];
      for (var element in transactions.docs) {
        final data = element.data() as Map<String, dynamic>?;
        if (data != null) {
          data['id'] = element.id; // Add the id to the data
          transactionsList.add(data);
        }
      }

      return transactionsList;
    } catch (e) {
      print('Error in getTransactions: $e');
      throw Exception('Failed to fetch transactions.');
    }
  }


  // get latest 10 transactions
  Future<List<Map<String, dynamic>>> getLatestTransactions(String uid) async {
    try {
      final transactions = await _firestore
          .collection(collectionName)
          .where('uid', isEqualTo: uid)
          .orderBy('timestamp', descending: true)
          .limit(10)
          .get();

      final List<Map<String, dynamic>> transactionsList = [];
      for (var element in transactions.docs) {
        final data = element.data() as Map<String, dynamic>?;
        if (data != null) {
          data['id'] = element.id; // Add the id to the data
          transactionsList.add(data);
        }
      }

      return transactionsList;
    } catch (e) {
      print('Error in getLatestTransactions: $e');
      throw Exception('Failed to fetch transactions.');
    }
  }
}
