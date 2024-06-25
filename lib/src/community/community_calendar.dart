import 'package:flutter/material.dart';
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
  final Map<DateTime, List<String>> _events = {
    DateTime.utc(2024, 6, 16): ['Event A0', 'Event B0', 'Event C0'],
    DateTime.utc(2024, 6, 17): ['Event A1', 'Event B1'],
    DateTime.utc(2024, 6, 18): [
      'Event A2',
      'Event B2',
      'Event C2',
      'Event D2',
      "Event E2",
      "Event F2",
      "Event G2",
    ],
    DateTime.utc(2024, 6, 19): ['Event A3', 'Event B3'],
    DateTime.utc(2024, 6, 20): ['Event A4', 'Event B4', 'Event C4'],
    DateTime.utc(2024, 6, 21): [
      'Event A5',
      'Event B5',
      'Event C5',
      'Event D5',
    ],
    DateTime.utc(2024, 6, 22): ['Event A6', 'Event B6'],
    DateTime.utc(2024, 6, 23): ['Event A7', 'Event B7', 'Event C7'],
    DateTime.utc(2024, 6, 24): [
      'Event A8',
      'Event B8',
      'Event C8',
      'Event D8',
    ],
    DateTime.utc(2024, 6, 25): ['Event A9', 'Event B9'],
    DateTime.utc(2024, 6, 26): ['Event A10', 'Event B10', 'Event C10'],
    DateTime.utc(2024, 6, 27): [
      'Event A11',
      'Event B11',
      'Event C11',
      'Event D11',
    ],
    DateTime.utc(2024, 6, 28): ['Event A12', 'Event B12'],
    DateTime.utc(2024, 6, 29): ['Event A13', 'Event B13', 'Event C13'],
    DateTime.utc(2024, 6, 30): [
      'Event A14',
      'Event B14',
      'Event C14',
      'Event D14',
    ],
    DateTime.utc(2024, 6, 31): ['Event A15', 'Event B15'],
  };

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(
      getEventsForDay(
        _selectedDay,
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
        title: const Text("Waste Pickup Schedule"),
        centerTitle: true,
      ),
      body: Column(
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
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 12, 20),
            calendarFormat: _calenderFormat,
            eventLoader: getEventsForDay,
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
                      ? const Center(
                          child: Text(
                            "Select a day to view events.",
                            style: TextStyle(
                              color: Colors.white,
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
      floatingActionButton: FloatingActionButton(
        onPressed: addEvent,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const NavBar(),
    );
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
    return _events[day] ?? [];
  }

  void addEvent() {
    if (_selectedDay != null) {
      setState(() {
        _events[_selectedDay!] = _events[_selectedDay!] ?? [];
        _events[_selectedDay!]!.add('Event at ${_selectedDay!.toLocal()}');
      });
    }
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
