import 'package:cloud_firestore/cloud_firestore.dart';

class HomeRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<double> getTotalBalance(String uid) async {
    double totalBalance = 0;
    try {
      final income = await _firestore
          .collection('incomes')
          .where('uid', isEqualTo: uid)
          .get();

      final expense = await _firestore
          .collection('expenses')
          .where('uid', isEqualTo: uid)
          .get();

      for (var element in income.docs) {
        totalBalance += element['income'];
      }

      for (var element in expense.docs) {
        totalBalance -= element['expense'];
      }

      print('Total balance calculated: $totalBalance');
      return totalBalance;
    } catch (e) {
      print('Error in getTotalBalance: $e');
      throw Exception('Failed to fetch total balance.');
    }
  }
}
