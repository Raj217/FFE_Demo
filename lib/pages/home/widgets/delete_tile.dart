import 'package:ffe_demo_app/models/task/task.dart';
import 'package:flutter/material.dart';

class DeleteTile extends StatefulWidget {
  final TaskModel task;
  final Animation<double> animation;
  const DeleteTile({super.key, required this.task, required this.animation});

  @override
  State<DeleteTile> createState() => _DeleteTileState();
}

class _DeleteTileState extends State<DeleteTile> {
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: widget.animation,
      child: Card(
        child: ListTile(
          title: Text(widget.task.title),
          subtitle: Text(
            widget.task.description,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
