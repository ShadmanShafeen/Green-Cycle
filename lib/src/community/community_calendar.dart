import 'package:flutter/material.dart';
import 'package:green_cycle/src/widgets/app_bar.dart';
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
  Map<DateTime, List<String>> events = {
    DateTime.utc(2024, 6, 17): ['Event A0', 'Event B0'],
    DateTime.utc(2024, 6, 18): ['Event A1', 'Event B1'],
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
      appBar: const CustomAppBar(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: addEvent,
        child: const Icon(Icons.add),
      ),
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

  void addEvent() {
    if (_selectedDay != null) {
      setState(() {
        events[_selectedDay!] = events[_selectedDay!] ?? [];
        events[_selectedDay!]!.add('Event at ${_selectedDay!.toLocal()}');
      });
    }
  }
}
