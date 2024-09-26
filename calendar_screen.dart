import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_create_eventify/database.dart';
import 'package:flutter_create_eventify/event_model.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // ignore: unused_field
   Map<DateTime, List<Event>> ?_events;
  DateTime _focusedDay = DateTime.now();
  DateTime _firstDay = DateTime.now().subtract(Duration(days: 365));
  DateTime _lastDay = DateTime.now().add(Duration(days: 365));

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  _loadEvents() async {
    final db = await DatabaseHelper().database;
    final events = await db.query('events');
    setState(() {
      _events = events.map((event) => Event.fromMap(event)).toList().fold(
        {},
        (map, event) {
          DateTime date = DateTime.parse(event.date!);
          return map!..addAll({date: [event]});
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: TableCalendar(
        focusedDay: _focusedDay,
        firstDay: _firstDay,
        lastDay: _lastDay,
        onDaySelected: (day, events) {
          setState(() {
            _focusedDay = day;
          });
        },
        calendarStyle: CalendarStyle(
          selectedTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          todayTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonTextStyle:
              TextStyle(fontSize: 15.0, color: Colors.white),
          formatButtonDecoration: BoxDecoration(
            color: Colors.deepOrange[400],
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );
  }
}