import 'package:ffe_demo_app/models/task/task.dart';
import 'package:ffe_demo_app/pages/home/widgets/view_overlay.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  final TaskModel task;
  final void Function() onDelete;
  final Animation<double> animation;
  const TaskTile(
      {super.key,
      required this.task,
      required this.onDelete,
      required this.animation});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animation,
      child: Card(
        child: ListTile(
          onTap: () => showDialog(
              context: context,
              builder: (context) => ViewTask(
                    task: widget.task,
                  )),
          title: Text(widget.task.title),
          subtitle: Text(
            widget.task.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.onDelete();
            },
          ),
        ),
      ),
    );
  }
}
