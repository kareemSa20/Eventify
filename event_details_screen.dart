import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_create_eventify/database.dart';
import 'package:flutter_create_eventify/event_model.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event ?event;

  EventDetailsScreen({this.event});

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event!.title!),
      ),
      body: ListView(
        children: [
          ListTile(
                      title: Text('Date: ${widget.event!.date}'),
          ),
          ListTile(
            title: Text('Time: ${widget.event!.time}'),
          ),
          ListTile(
            title: Text('Location: ${widget.event!.location}'),
          ),
          ListTile(
            title: Text('Description: ${widget.event!.description}'),
          ),
          ListTile(
            title: Text('Category: ${widget.event!.category}'),
          ),
          ListTile(
            title: Text('Reminder Time: ${widget.event!.reminderTime}'),
          ),
          ListTile(
            title: Text('Reminder Frequency: ${widget.event!.reminderFrequency}'),
          ),
          ElevatedButton(
            onPressed: () async {
              final db = await DatabaseHelper().database;
              await db.delete('events', where: 'id = ?', whereArgs: [widget.event!.id]);
              Navigator.pop(context);
            },
            child: Text('Delete Event'),
          ),
        ],
      ),
    );
  }
}