import 'dart:ui';
class Event {
  int? id;
  String? title;
  String?date;
  String? time;
  String? location;
  String? description;
  String? category;
  String? reminderTime;
  String? reminderFrequency;

  Event({
    this.id,
    this.title,
    this.date,
    this.time,
    this.location,
    this.description,
    this.category,
    this.reminderTime,
    this.reminderFrequency,
  });

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      title: map['title'],
      date: map['date'],
      time: map['time'],
      location: map['location'],
      description: map['description'],
      category: map['category'],
      reminderTime: map['reminderTime'],
      reminderFrequency: map['reminderFrequency'],
    );
  }
}