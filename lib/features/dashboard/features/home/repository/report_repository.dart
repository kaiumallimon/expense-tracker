import 'package:cloud_firestore/cloud_firestore.dart';

class ReportRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String expenseCollection = 'expenses';
  final String incomeCollection = 'incomes';

  // Helper function to get the start of the last 6 months
  DateTime _getSixMonthsAgo() {
    final now = DateTime.now();
    return DateTime(now.year, now.month - 6, now.day);
  }

  // Get expenses for the last 6 months
  Future<List<Map<String, dynamic>>> getExpensesLast6Months(String uid) async {
    try {
      final sixMonthsAgo = _getSixMonthsAgo();

      final expensesQuery = await _firestore
          .collection(expenseCollection)
          .where('uid', isEqualTo: uid)
          .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(sixMonthsAgo))
          .get();

      List<Map<String, dynamic>> expenses = [];
      for (var doc in expensesQuery.docs) {
        final data = doc.data();
        expenses.add({
          'amount': data['expense'],
          'timestamp': data['timestamp'],
        });
      }

      return expenses;
    } catch (e) {
      throw Exception('Failed to fetch expenses: $e');
    }
  }

  // Get incomes for the last 6 months
  Future<List<Map<String, dynamic>>> getIncomesLast6Months(String uid) async {
    try {
      final sixMonthsAgo = _getSixMonthsAgo();

      final incomesQuery = await _firestore
          .collection(incomeCollection)
          .where('uid', isEqualTo: uid)
          .where('timestamp', isGreaterThanOrEqualTo: Timestamp.fromDate(sixMonthsAgo))
          .get();

      List<Map<String, dynamic>> incomes = [];
      for (var doc in incomesQuery.docs) {
        final data = doc.data();
        incomes.add({
          'amount': data['income'],
          'timestamp': data['timestamp'],
        });
      }

      return incomes;
    } catch (e) {
      throw Exception('Failed to fetch incomes: $e');
    }
  }
}
