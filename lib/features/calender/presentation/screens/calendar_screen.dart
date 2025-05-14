import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_trackerr/core/shared/widgets/addhabit.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../core/layout/controller/cubit.dart';
import '../../../../../core/layout/controller/state.dart';
import '../../../../../core/shared/widgets/my_button.dart';
import '../../../../../core/shared/widgets/myformfield.dart';
import '../../../../../core/shared/widgets/toast/toast_state.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HabitCubit, HabitState>(
      listener: (context, state) {
        if (state is InsertDBState) {
          showToast(msg: 'habit added', state: ToastStates.success);
        }
        if (state is DeleteDBState) {
          showToast(msg: 'habit deleted', state: ToastStates.error);
        }
      },
      builder: (context, state) {
        final cubit = HabitCubit.get(context);
        final selectedDay = cubit.selectedDay;
        final focusedDay = cubit.focusedDay;



        return Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('MMMM yyyy').format(focusedDay),
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
                focusedDay: focusedDay,
                selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                onDaySelected: (selected, focused) {
                  cubit.updateSelectedDay(selected);
                  cubit.updateFocusedDay(focused);
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
                eventLoader: cubit.getEventsForDay,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: cubit.getEventsForDay(selectedDay).isEmpty
                    ? const Center(
                  child: Text(
                    'No tasks for this day',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
                    : ListView.builder(
                  itemCount: cubit.getEventsForDay(selectedDay).length,
                  itemBuilder: (context, index) {
                    final task = cubit.getEventsForDay(selectedDay)[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task['title'],
                                style: TextStyle(
                                  decoration: task['state'] == 'Yes'
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: task['state'] == 'Yes'
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                              if (task['state'] == 'Yes')
                                const Text(
                                  'Complete',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.green),
                                ),
                            ],
                          ),
                          leading: Checkbox(
                            value: task['state'] == 'Yes',
                            activeColor: Colors.green,
                            onChanged: (bool? value) {
                              cubit.updateStateDB(
                                id: task['id'],
                                state: value! ? 'Yes' : 'No',
                              );
                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => cubit.deleteDB(id: task['id']),
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
            onPressed: () {
              cubit.titleController.clear();
              cubit.descriptionController.clear();
              cubit.categoryController.text = 'Urgent & Important';
              _showAddTaskDialog(context, cubit, selectedDay);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            backgroundColor: const Color(0xFF00468C),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }

  void _showAddTaskDialog(BuildContext context, HabitCubit cubit, DateTime selectedDay) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);

    showDialog(
      context: context,
      builder: (context) => AddHabit(habit: cubit, date: formattedDate),
    );
  }
}