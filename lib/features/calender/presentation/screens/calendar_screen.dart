import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../../core/layout/controller/cubit.dart';
import '../../../../../core/layout/controller/state.dart';
import '../../../../../core/shared/widgets/my_button.dart';
import '../../../../../core/shared/widgets/myformfield.dart';
import '../../../../../core/shared/widgets/toast/toast_state.dart';

class CalendarScreen2 extends StatelessWidget {
  const CalendarScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitCubit, HabitState>(
      builder: (context, state) {
        final cubit = HabitCubit.get(context);
        final selectedDay = cubit.selectedDay;
        final focusedDay = cubit.focusedDay;

        List<Map> getEventsForDay(DateTime day) {
          final formattedDay = DateFormat('yyyy-MM-dd').format(day);
          return cubit.habits.where((habit) => habit['date'] == formattedDay).toList();
        }

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
                eventLoader: getEventsForDay,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: getEventsForDay(selectedDay).isEmpty
                    ? const Center(
                  child: Text(
                    'No tasks for this day',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
                    : ListView.builder(
                  itemCount: getEventsForDay(selectedDay).length,
                  itemBuilder: (context, index) {
                    final task = getEventsForDay(selectedDay)[index];
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
      builder: (context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: cubit.formKey,
          child: AlertDialog(
            title: Text(
              'Enter Your Task Details',
              style: TextStyle(
                color: const Color(0xFF00468C),
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(
                      color: const Color(0xFF00468C),
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  MyFormField(
                    controller: cubit.titleController,
                    type: TextInputType.text,
                    prefix: Icons.title,
                    isUpperCase: false,
                    text: 'ex: do math homework',
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Title must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Description',
                    style: TextStyle(
                      color: const Color(0xFF00468C),
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  MyFormField(
                    controller: cubit.descriptionController,
                    type: TextInputType.text,
                    prefix: Icons.description,
                    isUpperCase: false,
                    text: 'ex: Math Homework',
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Description must not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Category',
                    style: TextStyle(
                      color: const Color(0xFF00468C),
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButtonFormField(
                    isExpanded: true,
                    value: cubit.categoryController.text,
                    items: HabitCubit.categoryDrop,
                    onChanged: (value) {
                      cubit.categoryController.text = value.toString();
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: MyButton(
                          onPressed: () {
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.insertDB(
                                title: cubit.titleController.text,
                                des: cubit.descriptionController.text,
                                category: cubit.categoryController.text,
                                date: formattedDate,
                              );
                              Navigator.pop(context);
                            }
                          },
                          text: 'Create Task',
                          isUpperCase: false,
                          style: const TextStyle(color: Colors.white),
                          background: const Color(0xFF00468C),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: MyButton(
                          onPressed: () => Navigator.pop(context),
                          text: 'Cancel',
                          isUpperCase: false,
                          style: TextStyle(color: const Color(0xFF00468C)),
                          background: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}