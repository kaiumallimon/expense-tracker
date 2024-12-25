import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalenderViewRepository {
  final fireStore = FirebaseFirestore.instance;

  Future<Map<String, List<Map<String, dynamic>>>> getAllDataByDate(
      String uid) async {
    try {
      // Fetch incomes and expenses in parallel
      final futures = [
        fireStore
            .collection('incomes')
            .where('uid', isEqualTo: uid)
            .orderBy('timestamp', descending: true)
            .get(),
        fireStore
            .collection('expenses')
            .where('uid', isEqualTo: uid)
            .orderBy('timestamp', descending: true)
            .get(),
      ];

      final results = await Future.wait(futures);

      // Combine all documents and convert timestamps
      final List<Map<String, dynamic>> allData = results.expand((snapshot) {
        return snapshot.docs.map((doc) {
          final docData = doc.data();
          return {
            ...docData,
            'timestamp': docData['timestamp'].toDate(),
          };
        }).toList();
      }).toList();

      // Group data by date
      final Map<String, List<Map<String, dynamic>>> groupedData = {};

      for (final entry in allData) {
        // Format the date without the time
        final String dateKey =
            (entry['timestamp'] as DateTime).toLocal().toString().split(' ')[0];

        // Initialize the list for this date if not already present
        groupedData[dateKey] ??= [];

        // Add the entry to the corresponding date
        groupedData[dateKey]!.add(entry);
      }

      // Create final output structure
      final Map<String, List<Map<String, dynamic>>> formattedResponse = {};

      groupedData.forEach((date, entries) {
        // Sort entries by timestamp
        entries.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

        // Add to formatted response
        formattedResponse[date] = entries.map((entry) {
          final isIncome = entry.containsKey('income');
          return {
            isIncome ? 'income' : 'expense': entry,
          };
        }).toList();
      });

      return formattedResponse;
    } catch (e, stacktrace) {
      log('Error processing data: $e', stackTrace: stacktrace);
      return {};
    }
  }
}
