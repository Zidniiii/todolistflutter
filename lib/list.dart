import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final List<Map<String, dynamic>> _todos = [
    {'title': 'Belajar Flutter', 'done': false},
    {'title': 'Baca Buku', 'done': false},
    {'title': 'Olahraga', 'done': false},
  ];

  final TextEditingController _controller = TextEditingController();

  void _addTodo(String title) {
    if (title.trim().isEmpty) return;
    setState(() {
      _todos.add({'title': title.trim(), 'done': false});
    });
    _controller.clear();
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  void _toggleDone(int index) {
    setState(() {
      _todos[index]['done'] = !_todos[index]['done'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final String today = DateFormat.yMMMMEEEEd('id_ID').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: const Text("To-Do List"),
        backgroundColor: const Color(0xFF1B263B),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              today,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (_) => _toggleDone(index),
                  background: Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    color: Colors.green.shade400,
                    child: const Icon(Icons.check, color: Colors.white),
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF415A77),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(
                        todo['done']
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: todo['done'] ? Colors.greenAccent : Colors.white,
                      ),
                      title: Text(
                        todo['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          decoration: todo['done']
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Switch(
                            value: todo['done'],
                            activeColor: Colors.greenAccent,
                            onChanged: (value) {
                              setState(() {
                                _todos[index]['done'] = value;
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => _removeTodo(index),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Tambah Tugas"),
              content: TextField(
                controller: _controller,
                decoration: const InputDecoration(hintText: "Masukkan nama tugas"),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _controller.clear();
                  },
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addTodo(_controller.text);
                    Navigator.pop(context);
                  },
                  child: const Text("Tambah"),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}
