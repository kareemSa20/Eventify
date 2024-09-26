import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_create_eventify/database.dart';
//import 'package:flutter_create_eventify/event_model.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _category;
  String? _reminderTime;
  String? _reminderFrequency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a date';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a time';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a location';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            DropdownButtonFormField(
              value: _category,
              onChanged: (value) {
                setState(() {
                  _category = value;
                });
              },
              items: [
                DropdownMenuItem(
                  child: Text('Birthday'),
                  value: 'birthday',
                ),
                DropdownMenuItem(
                  child: Text('Holiday'),
                  value: 'holiday',
                ),
                DropdownMenuItem(
                  child: Text('Meeting'),
                  value: 'meeting',
                ),
              ],
            ),
            DropdownButtonFormField(
              value: _reminderTime,
              onChanged: (value) {
                setState(() {
                  _reminderTime = value;
                });
              },
              items: [
                DropdownMenuItem(
                  child: Text('1 hour before'),
                  value: '1 hour',
                ),
                DropdownMenuItem(
                  child: Text('1 day before'),
                  value: '1 day',
                ),
                DropdownMenuItem(
                  child: Text('1 week before'),
                  value: '1 week',
                ),
              ],
            ),
            DropdownButtonFormField(
              value: _reminderFrequency,
              onChanged: (value) {
                setState(() {
                  _reminderFrequency = value;
                });
              },
              items: [
                DropdownMenuItem(
                  child: Text('Once'),
                  value: 'once',
                ),
                DropdownMenuItem(
                  child: Text('Daily'),
                  value: 'daily',
                ),
                DropdownMenuItem(
                  child: Text('Weekly'),
                  value: 'weekly',
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final db = await DatabaseHelper().database;
                  await db.insert('events', {
                    'title': _titleController.text,
                    'date': _dateController.text,
                    'time': _timeController.text,
                    'location': _locationController.text,
                    'description': _descriptionController.text,
                    'category': _category,
                    'reminderTime': _reminderTime,
                    'reminderFrequency': _reminderFrequency,
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add Event'),
            ),
          ],
        ),
      ),
    );
  }
}
