import 'package:ffe_demo_app/config/tasks/list_of_tasks.dart';
import 'package:ffe_demo_app/controllers/task/task_controller.dart';
import 'package:ffe_demo_app/models/task/task.dart';
import 'package:ffe_demo_app/pages/home/widgets/appbar.dart';
import 'package:ffe_demo_app/pages/home/widgets/create_overlay.dart';
import 'package:ffe_demo_app/pages/home/widgets/delete_tile.dart';
import 'package:ffe_demo_app/pages/home/widgets/task_tile.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  static const String route = "/homepage";
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: listOfTasks.isEmpty
            ? const Center(child: Text("No tasks!"))
            : AnimatedList(
                key: _listKey,
                initialItemCount: listOfTasks.length,
                itemBuilder: (context, index, animation) => TaskTile(
                    task: listOfTasks[index],
                    animation: animation,
                    onDelete: () {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Deleted task!")));
                      TaskModel tobeDeleted = listOfTasks[index];
                      AnimatedList.of(context).removeItem(
                        index,
                        (context, animation) =>
                            DeleteTile(task: tobeDeleted, animation: animation),
                      );
                      TaskController.deleteTask(tobeDeleted);
                      setState(() {});
                    }),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showDialog(
                context: context,
                builder: (context) => CreateTask(
                      listKey: _listKey,
                    ));
            setState(() {});
          },
          child: const Icon(Icons.add),
        ));
  }
}
