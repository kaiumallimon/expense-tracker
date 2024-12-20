import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logics/transactions_bloc.dart';
import '../logics/transactions_event.dart';
import '../logics/transactions_state.dart';

class TransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          TransactionsBloc()..add(FetchTransactions(filter: 'All', limit: 10)),
      child: TransactionsView(),
    );
  }
}

class TransactionsView extends StatefulWidget {
  @override
  _TransactionsViewState createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  String _selectedFilter = 'All'; // Default filter
  List<Map<String, dynamic>> _transactions =
      []; // To hold all fetched transactions
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  void _onFilterSelected(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
    // Dispatch event to apply filter
    context
        .read<TransactionsBloc>()
        .add(FetchTransactions(filter: filter, limit: 10));
  }

  List<Map<String, dynamic>> _getFilteredTransactions(
      List<Map<String, dynamic>> transactions) {
    List<Map<String, dynamic>> filteredTransactions = transactions;

    // Filter transactions based on the selected filter
    if (_selectedFilter == 'Income') {
      filteredTransactions = transactions
          .where((transaction) => transaction['type'] == 'income')
          .toList();
    } else if (_selectedFilter == 'Expense') {
      filteredTransactions = transactions
          .where((transaction) => transaction['type'] == 'expense')
          .toList();
    }

    // Further filter transactions based on search text for various fields
    if (_searchText.isNotEmpty) {
      filteredTransactions = filteredTransactions.where((transaction) {
        // Check if any field contains the search text (case-insensitive)
        return transaction['description']
                .toLowerCase()
                .contains(_searchText.toLowerCase()) ||
            transaction['amount'].toString().contains(_searchText) ||
            (transaction['timestamp'] is Timestamp
                ? (transaction['timestamp'] as Timestamp)
                    .toDate()
                    .toString()
                    .contains(_searchText)
                : false);
      }).toList();
    }

    // Further filter transactions based on date if applicable
    DateTime? searchDate = DateTime.tryParse(_searchText);
    if (searchDate != null) {
      filteredTransactions = filteredTransactions.where((transaction) {
        final timestamp = transaction['timestamp'] is Timestamp
            ? (transaction['timestamp'] as Timestamp).toDate()
            : DateTime.now();
        return timestamp.year == searchDate.year &&
            timestamp.month == searchDate.month &&
            timestamp.day == searchDate.day;
      }).toList();
    }

    return filteredTransactions;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        if (state is TransactionsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TransactionsSuccess) {
          _transactions = state.transactions;

          // Filter transactions based on selected filter and search text
          final filteredTransactions = _getFilteredTransactions(_transactions);

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transactions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.primary,
                  ),
                ),
                const SizedBox(height: 20),

                // Search Field
                CupertinoSearchTextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                  placeholder: 'Search transactions',
                  prefixIcon: Icon(CupertinoIcons.search, color: theme.primary),
                  padding: const EdgeInsets.all(10),
                  suffixIcon:
                      Icon(Icons.clear_rounded, color: theme.error, size: 20),
                ),
                const SizedBox(height: 20),

                // Filter Row - Add options here
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FilterOptionButton(
                      label: 'All',
                      isSelected: _selectedFilter == 'All',
                      onPressed: () => _onFilterSelected('All'),
                    ),
                    const SizedBox(width: 10),
                    FilterOptionButton(
                      label: 'Income',
                      isSelected: _selectedFilter == 'Income',
                      onPressed: () => _onFilterSelected('Income'),
                    ),
                    const SizedBox(width: 10),
                    FilterOptionButton(
                      label: 'Expense',
                      isSelected: _selectedFilter == 'Expense',
                      onPressed: () => _onFilterSelected('Expense'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                filteredTransactions.isEmpty
                    ? const Expanded(
                        child: Center(child: Text('No transactions found.')))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: filteredTransactions.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final transaction = filteredTransactions[index];
                            final timestamp =
                                transaction['timestamp'] is Timestamp
                                    ? (transaction['timestamp'] as Timestamp)
                                        .toDate()
                                    : DateTime.now();

                            return Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: theme.primary.withOpacity(.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.history, color: theme.primary),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          transaction['type']
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                            color:
                                                transaction['type'] == 'expense'
                                                    ? theme.error
                                                    : theme.secondary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          transaction['type'] == 'expense'
                                              ? ' - BDT ${transaction['amount']}'
                                              : '+ BDT ${transaction['amount']}',
                                          style: TextStyle(
                                            color: transaction['type'] ==
                                                    'expense'
                                                ? theme.error
                                                : CupertinoColors.activeGreen,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          transaction['description'],
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            color:
                                                theme.onSurface.withOpacity(.5),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Row(
                                    children: [
                                      Text(
                                          '${timestamp.day}/${timestamp.month}/${timestamp.year}'),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          );
        } else if (state is TransactionsFailure) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return Center(child: Text('No data available.'));
      },
    );
  }
}

class FilterOptionButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  FilterOptionButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? theme.primary : theme.surface,
        foregroundColor: isSelected ? theme.onPrimary : theme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: theme.primary),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? theme.onPrimary : theme.primary,
          fontSize: 14,
        ),
      ),
    );
  }
}
