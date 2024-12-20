import 'package:cloud_firestore/cloud_firestore.dart';

class AddRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String incomeCollection = 'incomes';
  final String logCollection = 'logs';

  Future<Map<String, dynamic>> addIncome(
      String uid, double income, String description) async {
    try {
      // Use a Firestore transaction for atomicity
      await _firestore.runTransaction((transaction) async {
        // Add income entry
        final incomeRef = _firestore.collection(incomeCollection).doc();
        transaction.set(incomeRef, {
          'uid': uid,
          'income': income,
          'description': description,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Add log entry
        final logRef = _firestore.collection(logCollection).doc();
        transaction.set(logRef, {
          'uid': uid,
          'type': 'income',
          'description': description,
          'amount': income,
          'timestamp': FieldValue.serverTimestamp(),
        });
      });

      return {'status': 'success', 'message': 'Income added successfully'};
    } catch (e) {
      return {
        'status': 'error',
        'error': 'Failed to add income: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> addExpense(
      String uid, double expense, String description) async {
    try {
      // Use a Firestore transaction for atomicity
      await _firestore.runTransaction((transaction) async {
        // Add expense entry
        final expenseRef = _firestore.collection('expenses').doc();
        transaction.set(expenseRef, {
          'uid': uid,
          'expense': expense,
          'description': description,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Add log entry
        final logRef = _firestore.collection(logCollection).doc();
        transaction.set(logRef, {
          'uid': uid,
          'type': 'expense',
          'description': description,
          'amount': expense,
          'timestamp': FieldValue.serverTimestamp(),
        });
      });

      return {'status': 'success', 'message': 'Expense added successfully'};
    } catch (e) {
      return {
        'status': 'error',
        'error': 'Failed to add expense: ${e.toString()}',
      };
    }
  }

}
