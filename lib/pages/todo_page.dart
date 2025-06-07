import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/components/dialog_buttons.dart';
import 'package:todo_app/components/task_tile.dart';
import 'package:todo_app/data/database.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  ToDoDatabase db = ToDoDatabase();
  final _myBox = Hive.box('mybox');
  final _controller = TextEditingController();

  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.initializeDatabase();
    } else {
      db.loadData();
    }

    super.initState();
  }

  void _toggleCheckBox(int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updatedDB();
  }

  void _submit() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      Navigator.of(context).pop();
    });
    db.updatedDB();
  }

  void addTaskPrompt() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Add a new task..',
                            hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DialogButton(buttonName: 'Submit', onPressed: _submit),
                        DialogButton(
                            buttonName: 'Cancel',
                            onPressed: () {
                              Navigator.of(context).pop();
                              _controller.clear();
                            })
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _delete(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updatedDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(
          child: Column(
            children: [
              DrawerHeader(
                  child: Icon(
                Icons.sticky_note_2_rounded,
                size: 50,
              )),
              ListTile(
                minTileHeight: 100,
                title: Text('H O M E'),
                leading: Icon(Icons.home_rounded),
              ),
              ListTile(
                minTileHeight: 100,
                title: Text('S E T T I N G S'),
                leading: Icon(Icons.settings),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('TO DO'),
          elevation: 5,
          shadowColor: Colors.black,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addTaskPrompt,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
        body: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return TaskTile(
                taskName: db.toDoList[index][0],
                isFinished: db.toDoList[index][1],
                onChanged: (value) => _toggleCheckBox(index),
                delete: (context) => _delete(index),
              );
            }));
  }
}
