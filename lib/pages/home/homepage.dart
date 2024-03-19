import 'package:ffe_demo_app/models/task/task.dart';
import 'package:ffe_demo_app/pages/home/widgets/appbar.dart';
import 'package:ffe_demo_app/pages/home/widgets/create_overlay.dart';
import 'package:ffe_demo_app/pages/home/widgets/delete_tile.dart';
import 'package:ffe_demo_app/pages/home/widgets/task_tile.dart';
import 'package:ffe_demo_app/states/states.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ffe_demo_app/widgets/widgets.dart';

class Homepage extends StatefulWidget {
  static const String route = "/homepage";
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  Future<void> fetchTasks() async {
    setState(() {
      isLoading = true;
    });
    try {
      TasksProvider tasksProvider =
          Provider.of<TasksProvider>(context, listen: false);

      String token = Provider.of<AuthProvider>(context, listen: false).token!;
      await tasksProvider.fetchAllTask(token: token);
    } catch (e) {
      rethrow;
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<TaskModel> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(
        builder: (context, TasksProvider tasksProvider, _) {
      return Scaffold(
        appBar: const CustomAppBar(),
        body: Builder(builder: (context) {
          if (isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: fetchTasks,
            child: tasksProvider.tasks.isEmpty
                ? const Center(child: Text("No tasks!"))
                : AnimatedList(
                    key: _listKey,
                    initialItemCount: tasksProvider.tasks.length,
                    itemBuilder: (context, index, animation) => TaskTile(
                      task: tasksProvider.tasks[index],
                      animation: animation,
                      onDelete: () async {
                        TaskModel tobeDeleted = tasksProvider.tasks[index];

                        String token =
                            Provider.of<AuthProvider>(context, listen: false)
                                .token!;
                        await tasksProvider.deleteTask(
                          token: token,
                          id: tobeDeleted.id!,
                        );
                        AnimatedList.of(context).removeItem(
                          index,
                          (context, animation) => DeleteTile(
                              task: tobeDeleted, animation: animation),
                        );
                        showSnackBar(context, "Deleted task!");
                      },
                    ),
                  ),
          );
        }),
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
        ),
      );
    });
  }
}
