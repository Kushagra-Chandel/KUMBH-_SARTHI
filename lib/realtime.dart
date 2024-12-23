import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class RealTimeUpdatesScreen extends StatefulWidget {
  const RealTimeUpdatesScreen({super.key});

  @override
  State<RealTimeUpdatesScreen> createState() => _RealTimeUpdatesScreenState();
}

class _RealTimeUpdatesScreenState extends State<RealTimeUpdatesScreen> {
  DateTime _selectedDate = DateTime.now();
  final Map<DateTime, List<String>> _events = {
    DateTime(2025, 1, 14): ['Makar Sankranti'],
    DateTime(2025, 3, 8): ['Holi'],
    DateTime(2025, 4, 21): ['Ram Navami'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-time Updates'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          _buildCalendar(),
          const SizedBox(height: 10),
          _buildEventList(),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: _selectedDate,
      firstDay: DateTime(2023, 1, 1),
      lastDay: DateTime(2025, 12, 31),
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
        });
      },
      eventLoader: (day) => _events[day] ?? [],
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        markerDecoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildEventList() {
    final events = _events[_selectedDate] ?? [];
    return Expanded(
      child: events.isEmpty
          ? const Center(
              child: Text(
                'No events for this day',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            )
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.event, color: Colors.orange),
                    title: Text(events[index]),
                    subtitle: Text('Details about ${events[index]}'),
                  ),
                );
              },
            ),
    );
  }
}
