import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../logics/calender_view_bloc.dart';
import '../logics/calender_view_event.dart';
import '../logics/calender_view_state.dart';

class CalenderView extends StatelessWidget {
  const CalenderView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    Future.delayed(Duration.zero, () {
      // ignore: use_build_context_synchronously
      context.read<CalenderViewBloc>().add(LoadCalenderView());
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // AppBar-style title
          Text(
            'Day-wise View',
            style: TextStyle(
                color: theme.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),

          Text(
            'Based on usage',
            style: TextStyle(color: theme.onSurface.withOpacity(.5)),
          ),
          const SizedBox(height: 10),
          // Calendar widget with BlocBuilder
          Expanded(
            child: BlocBuilder<CalenderViewBloc, CalenderViewState>(
              builder: (context, state) {
                if (state is CalenderViewLoading) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      radius: 15,
                      color: theme.primary,
                    ),
                  );
                } else if (state is CalenderViewLoaded) {
                  return buildCalendar(theme, state.data, context)
                      .animate()
                      .fade(
                        curve: Curves.easeIn,
                        duration: const Duration(milliseconds: 800),
                      )
                      .scaleXY(
                        begin: 0.9,
                        end: 1.0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 800),
                      );
                } else if (state is CalenderViewError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: theme.error),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("No data available."),
                  )
                      .animate()
                      .fade(
                        curve: Curves.easeIn,
                        duration: const Duration(milliseconds: 800),
                      )
                      .scaleXY(
                        begin: 0.9,
                        end: 1.0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 800),
                      );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCalendar(ColorScheme theme,
      Map<String, List<Map<String, dynamic>>> data, BuildContext context) {
    // Check if the data is empty
    if (data.isEmpty) {
      return Center(
        child: Text(
          "No data available.",
          style: TextStyle(color: theme.error),
        ),
      );
    }

    // Map data to Calendar events
    final List<CalendarEvent> events = [];

    data.forEach((date, entries) {
      for (final entry in entries) {
        final eventDate = DateTime.parse(date); // Parse the date once

        if (entry.containsKey('income')) {
          events.add(
            CalendarEvent(
              date: eventDate,
              description: entry['income']['description'] ?? 'No description',
              amount: entry['income']['income'] ?? 0.0,
              type: EventType.income,
            ),
          );
        } else if (entry.containsKey('expense')) {
          events.add(
            CalendarEvent(
              date: eventDate,
              description: entry['expense']['description'] ?? 'No description',
              amount: entry['expense']['expense'] ?? 0.0,
              type: EventType.expense,
            ),
          );
        }
      }
    });

    // Check if events are generated
    if (events.isEmpty) {
      return Center(
        child: Text(
          "No events available for the selected date range.",
          style: TextStyle(color: theme.error),
        ),
      );
    }

    return SfCalendar(
      // set background color for the calendar
      backgroundColor: theme.surface,

      // set the calendar view settings
      scheduleViewSettings: ScheduleViewSettings(
        monthHeaderSettings: const MonthHeaderSettings(height: 150),
        appointmentItemHeight: 50,
        appointmentTextStyle: TextStyle(
          color: theme.onSurface,
          fontSize: 15,
        ),
      ),

      // set the month header builder
      scheduleViewMonthHeaderBuilder: (context, details) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.primary,
          ),
          child: Row(
            children: [
              Text(
                DateFormat.yMMM().format(details.date),
                style: TextStyle(
                  color: theme.onPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },

      // set the view to schedule
      view: CalendarView.schedule,

      // set the selection mode to single
      todayHighlightColor: theme.primary,

      // set the selection decoration
      selectionDecoration: BoxDecoration(
        color: theme.primary.withOpacity(0.3),
        border: Border.all(color: theme.primary, width: 2),
        shape: BoxShape.circle,
      ),

      // set the data source
      dataSource: CalendarViewDataSource(events: events),

      // set the month view settings
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
      ),

      // set the header height
      headerHeight: 50,

      // set the header style
      headerStyle: CalendarHeaderStyle(
        backgroundColor: theme.surface,
        textStyle: TextStyle(
          color: theme.tertiary,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.left,
      ),

      // set the minimum date to the first date in the data
      minDate: events.last.date,

      // Set the initial display date to the current date
      initialSelectedDate: DateTime.now(),

      // limit the max date to the current date
      maxDate: DateTime.now(),

      // Add onTap functionality to handle event tap
      onTap: (details) {
        if (details.appointments != null && details.appointments!.isNotEmpty) {
          final event = details.appointments!.first as CalendarEvent;

          // Show a dialog or navigate to a new screen to display event details
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Event Details',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.primary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text('Description: ${event.description}'),
                        Text('Amount: ${event.amount}'),
                        Text('Added: ${formatDate(event.date)}'),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Close'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  // function to format date : MMM YYY, e.g. Jan 2022 using intl
  String formatDate(DateTime date) {
    return DateFormat.yMMM().format(date);
  }
}

// Event Type Enum
enum EventType { income, expense }

// Calendar Event Model
class CalendarEvent {
  final DateTime date;
  final String description;
  final double amount;
  final EventType type;

  CalendarEvent({
    required this.date,
    required this.description,
    required this.amount,
    required this.type,
  });
}

// Calendar Data Source
class CalendarViewDataSource extends CalendarDataSource {
  CalendarViewDataSource({required List<CalendarEvent> events}) {
    appointments = events;
  }

  @override
  DateTime getStartTime(int index) => appointments![index].date;

  @override
  DateTime getEndTime(int index) => appointments![index].date;

  @override
  String getSubject(int index) {
    final event = appointments![index];
    String description =
        event.description.isNotEmpty ? event.description : 'No description';

    if (event.type == EventType.income) {
      return '$description: ${event.amount}';
    } else {
      return '$description: ${event.amount}';
    }
  }

  @override
  Color getColor(int index) {
    return appointments![index].type == EventType.income
        ? Colors.green
        : Colors.red;
  }

  @override
  bool isAllDay(int index) => true;
}
