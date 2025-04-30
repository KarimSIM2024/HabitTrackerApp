
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

// Task class to store task info including completion status
class Task {
  String title;
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});
}

class CalendarPage extends StatefulWidget {
  final String username;

  const CalendarPage({Key? key, required this.username}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  // Tasks map with date as the key and list of tasks as the value
  final Map<DateTime, List<Task>> _events = {};

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  // Method to get tasks for a specific day
  List<Task> _getEventsForDay(DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    return _events[normalizedDay] ?? [];
  }

  // Method to add a new task
  void _addTask() {
    final TextEditingController taskController = TextEditingController();

    // Show dialog to add a new task
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
        content: TextField(
          controller: taskController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter task',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final text = taskController.text;
              if (text.isNotEmpty) {
                setState(() {
                  final dateKey = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
                  final newTask = Task(title: text);

                  if (_events[dateKey] != null) {
                    _events[dateKey]!.add(newTask);
                  } else {
                    _events[dateKey] = [newTask];
                  }
                });
              }
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // Method to toggle task completion status
  void _toggleTaskCompletion(int index) {
    final dateKey = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);

    setState(() {
      final task = _events[dateKey]![index];
      task.isCompleted = !task.isCompleted;
    });
  }

  // Method to delete a task
  void _deleteTask(int index) {
    final dateKey = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _events[dateKey]!.removeAt(index);
                if (_events[dateKey]!.isEmpty) {
                  _events.remove(dateKey);
                }
              });
              Navigator.of(context).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome ${widget.username}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0066CC),
                  ),
                ),
                const Text(
                  'Let\'s create your To Do List Now',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF0066CC),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  DateFormat('MMMM yyyy').format(_focusedDay),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0066CC),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarFormat: CalendarFormat.month,
            headerVisible: false,
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color(0xFF0066CC),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            eventLoader: _getEventsForDay,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _getEventsForDay(_selectedDay).isEmpty
                ? const Center(
              child: Text(
                'No tasks for this day',
                style: TextStyle(color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: _getEventsForDay(_selectedDay).length,
              itemBuilder: (context, index) {
                final task = _getEventsForDay(_selectedDay)[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                              color: task.isCompleted ? Colors.grey : Colors.black,
                            ),
                          ),
                          if (task.isCompleted)
                            const Text(
                              'Complete',
                              style: TextStyle(fontSize: 12, color: Colors.green),
                            ),
                        ],
                      ),
                      leading: Checkbox(
                        value: task.isCompleted,
                        activeColor: Colors.green,
                        onChanged: (bool? value) {
                          _toggleTaskCompletion(index);
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteTask(index),
                      ),
                    ),
                    const Divider(height: 1),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        backgroundColor: const Color(0xFF0066CC),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: const Color(0xFF0066CC),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
