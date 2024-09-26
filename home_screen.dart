import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_create_eventify/database.dart';
import 'package:flutter_create_eventify/event_model.dart';
import 'package:flutter_create_eventify/add_event_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Event> _events = [];

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  _loadEvents() async {
    final db = await DatabaseHelper().database;
    final events = await db.query('events');
    setState(() {
      _events = events.map((event) => Event.fromMap(event)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventify'),
      ),
      body: ListView.builder(
        itemCount: _events.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_events[index].title!),
              subtitle: Text(_events[index].date!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEventScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
