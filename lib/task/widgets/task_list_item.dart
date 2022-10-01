import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:productivity_local/task/models/task.dart';
import 'package:productivity_local/task/provider/task_data.dart';
import 'package:productivity_local/task/widgets/task_tile.dart';
import '../provider/task_data.dart';
import 'package:productivity_local/constant.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({Key? key}) : super(key: key);

  // List<Task>? tsk;
  // TaskListView({this.tsk});
  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  List<Task> tasks = [];
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    // Provider.of<TaskData>(context, listen: false).getTasks();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<TaskData>(context, listen: true);
    return Container(
      padding: const EdgeInsets.all(30),
      height: 200,
      decoration: BoxDecoration(
        color: primaryClr,
        gradient: LinearGradient(
          colors: [primaryClr, primaryClr],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ListView.builder(
        itemCount: provider.tasks.length,
        itemBuilder: (context, index) {
          Task? tsk = provider.tasks[index];
          bool? isTop;
          bool? isSame() {
            if (index != 0) {
              String taskDate =
                  '${tsk.createdAt?.year}${tsk.createdAt?.month}${tsk.createdAt?.day}';
              String lastTaskDate =
                  '${provider.tasks[index - 1].createdAt?.year}${provider.tasks[index - 1].createdAt!.month}${provider.tasks[index - 1].createdAt!.day}';
              if (taskDate == lastTaskDate) {
                return false;
              } else {
                return true;
              }
            }
          }

          // bool isisSameDate = '${taskData.tasks[index --].createdAt!.day}' == '${taskData.tasks[index].createdAt!.day}/${taskData.tasks[index].createdAt!.month}';
          return Column(
            children: [
              isSame() ?? true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // '${tsk.createdAt!.day}/${tsk.createdAt!.month}',
                          '${tsk.createdAt!.year}/${tsk.createdAt!.month}/${tsk.createdAt!.day}',
                          style: TextStyle(color: secondaryClr),
                        ),
                        Expanded(
                            child: Container(
                          color: secondaryClr,
                          width: 300,
                          height: 1,
                        ))
                      ],
                    )
                  : Container(),
              TaskTile(
                  title: tsk.title ?? '',
                  subtitle: tsk.subtitle ?? '',
                  isChecked: tsk.isDone == 0 ? false : true,
                  onLongPress: () {
                    provider.deletingTask(tsk);
                    Task.encode(provider.tasks);
                  },
                  onChanged: (checkboxState) {
                    provider.checkTask(tsk);
                    // Task.encode(provider.tasks);
                  }),
            ],
          );
        },
      ),
    );
  }
}
