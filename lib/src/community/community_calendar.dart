import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle/auth.dart';
import 'package:green_cycle/src/utils/server.dart';
import 'package:green_cycle/src/utils/snackbars_alerts.dart';
import 'package:green_cycle/src/widgets/nav_bar.dart';
import 'package:table_calendar/table_calendar.dart';

class CommunityCalendar extends StatefulWidget {
  const CommunityCalendar({super.key});

  @override
  CalendarScreenState createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CommunityCalendar> {
  CalendarFormat _calenderFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late final ValueNotifier<List<String>> _selectedEvents;
  Map<DateTime, List<String>> events = {};

  @override
  void initState() {
    super.initState();
    fetchEvents();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(
      getEventsForDay(
        DateTime.parse('${DateTime(
          _selectedDay!.year,
          _selectedDay!.month,
          _selectedDay!.day,
        ).toIso8601String()}Z'),
      ),
    );
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Community Schedule",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        centerTitle: true,
      ),
      bottomNavigationBar: const NavBar(),
      body: Container(
        color: Theme.of(context).colorScheme.surfaceContainerLowest,
        child: Column(
          children: [
            TableCalendar<String>(
              headerStyle: const HeaderStyle(
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              calendarStyle: calendarStyle,
              eventLoader: getEventsForDay,
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 12, 20),
              calendarFormat: _calenderFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                  });

                  _selectedEvents.value = getEventsForDay(selectedDay);
                }
              },
              onFormatChanged: (format) {
                if (_calenderFormat != format) {
                  setState(() {
                    _calenderFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ValueListenableBuilder<List<String>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return _selectedEvents.value.isEmpty
                        ? Center(
                            child: Text(
                              "Select a day with events to view them.",
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return getEventCard(value[index]);
                            },
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void fetchEvents() async {
    final Dio dio = Dio();
    try {
      final Auth auth = Auth();
      final response = await dio.get(
        '$serverURLExpress/community-events/${auth.currentUser?.email}',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        for (final event in data) {
          final DateTime date = DateTime.parse(event['date']);
          setState(() {
            events[date] = events[date] ?? [];
            events[date]!.add(event['event']);
          });
          _selectedEvents.value = getEventsForDay(DateTime.parse('${DateTime(
            _selectedDay!.year,
            _selectedDay!.month,
            _selectedDay!.day,
          ).toIso8601String()}Z'));
        }
      }
    } catch (e) {
      // quick alert
      createQuickAlert(
        context: context.mounted ? context : context,
        title: "Error fetching events",
        message: "$e",
        type: "error",
      );
    }
  }

  final CalendarStyle calendarStyle = const CalendarStyle(
    defaultTextStyle: TextStyle(
      color: Colors.blue,
    ),
    weekendTextStyle: TextStyle(
      color: Colors.purple,
    ),
    markerSize: 5,
    markerDecoration: BoxDecoration(
      color: Colors.white24,
      shape: BoxShape.circle,
    ),
    outsideTextStyle: TextStyle(
      color: Colors.white24,
    ),
    todayTextStyle: TextStyle(
      color: Colors.black,
    ),
  );

  List<String> getEventsForDay(DateTime? day) {
    if (day == null) {
      return [];
    }
    return events[day] ?? [];
  }

  Card getEventCard(String event) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () {},
        splashColor: Colors.grey,
        trailing: const Icon(Icons.arrow_right),
        title: Text(event),
      ),
    );
  }
}
