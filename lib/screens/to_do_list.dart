import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<String> tasks = [];

  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      tasks = prefs.getStringList('tasks') ?? [];
    });
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('tasks', tasks);
  }

  void _addTask(String task) {
    if (task.trim().isEmpty) return;

    setState(() {
      tasks.add(task);
    });
    _saveTasks();
    _taskController.clear();
    Navigator.pop(context);
  }

  void _showAddTaskSheet() {
    showModalBottomSheet(
      backgroundColor: const Color(0xff272727),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _taskController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter a new task',
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: const Color(0xff3a3a3a),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _addTask(_taskController.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xff272727),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff272727),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xff272727),
        centerTitle: true,
        title: Text(
          'To Do List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text(
                'No Tasks Yet!',
                style: TextStyle(color: Colors.white54),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: tasks.length,
              separatorBuilder: (_, _) => const Divider(
                color: Colors.white12,
                thickness: 0.5,
                indent: 20,
                endIndent: 20,
              ),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white12,
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  title: Text(
                    tasks[index],
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xff272727),
        onPressed: _showAddTaskSheet,
        child: Icon(Icons.add),
      ),
    );
  }
}
