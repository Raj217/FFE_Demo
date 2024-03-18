import 'package:ffe_demo_app/models/task/task.dart';
import 'package:ffe_demo_app/pages/home/widgets/view_overlay.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  final TaskModel task;
  final Future<void> Function() onDelete;
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
  bool isDeleting = false;
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
            icon: isDeleting
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.delete),
            onPressed: () async {
              setState(() {
                isDeleting = true;
              });
              try {
                await widget.onDelete();
              } catch (e) {
                rethrow;
              } finally {
                isDeleting = false;
              }
            },
          ),
        ),
      ),
    );
  }
}
