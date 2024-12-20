import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ReportChart extends StatefulWidget {
  final String uid;

  final List<Map<String, dynamic>> expenses;
  final List<Map<String, dynamic>> incomes;

  ReportChart(
      {required this.uid, required this.expenses, required this.incomes});

  @override
  _ReportChartState createState() => _ReportChartState();
}

class _ReportChartState extends State<ReportChart> {
  List<FlSpot> _expenseSpots = [];
  List<FlSpot> _incomeSpots = [];
  List<String> _months = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchData() async {
    setState(() {
      _expenseSpots = _generateMonthlySpots(widget.expenses);
      _incomeSpots = _generateMonthlySpots(widget.incomes);
    });
  }

  List<FlSpot> _generateMonthlySpots(List<Map<String, dynamic>> data) {
    final now = DateTime.now();
    final sixMonthsAgo = DateTime(now.year, now.month - 5, 1);
    List<FlSpot> spots = [];
    _months = [];
    for (int i = 0; i < 6; i++) {
      final month = DateTime(sixMonthsAgo.year, sixMonthsAgo.month + i, 1);
      _months.add(DateFormat.MMM().format(month));
      final monthData = data.where((entry) {
        final entryDate = entry['timestamp'] != null
            ? (entry['timestamp'] as Timestamp).toDate()
            : DateTime(1970);
        return entryDate.year == month.year && entryDate.month == month.month;
      }).toList();

      final totalAmount =
          monthData.fold(0.0, (sum, entry) => sum + entry['amount']);
      spots.add(FlSpot(i.toDouble(), totalAmount));
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return FutureBuilder(
      future: _fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Column(
            children: [
              const SizedBox(height: 30),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Incomes of the last 6 months',
                      style: TextStyle(
                          color: CupertinoColors.activeGreen,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: _incomeSpots,
                        isCurved: false,
                        color: CupertinoColors.activeGreen,
                        barWidth: 4,
                        gradient: LinearGradient(
                            colors: [theme.primary, theme.tertiary]),
                        belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(colors: [
                              theme.primary.withOpacity(.3),
                              theme.tertiary.withOpacity(.3)
                            ]),
                            color: CupertinoColors.activeGreen.withOpacity(.3)),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(_months[value.toInt()]);
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Expenses of the last 6 months',
                      style: TextStyle(
                          color: theme.error,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: _expenseSpots,
                        isCurved: false,
                        color: theme.error,
                        barWidth: 4,
                        belowBarData: BarAreaData(
                            show: true, color: theme.error.withOpacity(.3)),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(_months[value.toInt()]);
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
