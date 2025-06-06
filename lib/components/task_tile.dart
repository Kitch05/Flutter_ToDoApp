import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskTile extends StatelessWidget {
  final String taskName;
  final bool isFinished;
  Function(bool?)? onChanged;
  Function(BuildContext?)? delete;

  TaskTile(
      {super.key,
      required this.taskName,
      required this.isFinished,
      required this.onChanged,
      required this.delete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
      child: Slidable(
        endActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
            onPressed: delete,
            icon: Icons.delete_forever_outlined,
            backgroundColor: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(10),
          )
        ]),
        child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Checkbox(value: isFinished, onChanged: onChanged),
                  Text(
                    taskName,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 16,
                        decoration:
                            isFinished ? TextDecoration.lineThrough : null,
                        decorationColor:
                            Theme.of(context).colorScheme.onSecondary),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
