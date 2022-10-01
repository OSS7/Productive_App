import 'package:flutter/material.dart';
import 'package:productivity_local/constant.dart';
import 'package:productivity_local/task/provider/task_data.dart';
import 'package:productivity_local/task/widgets/bottom_sheet.dart';
import 'package:productivity_local/task/widgets/task_list_item.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    final providerF = Provider.of<TaskData>(context, listen: false);

    return SafeArea(
            child: Scaffold(
              backgroundColor: secondaryClr,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    color: secondaryClr,
                    padding: const EdgeInsets.only(
                        left: 20, top: 20, right: 1, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [
                            Text(
                              'Tasks',
                              style: TextStyle(
                                color: primaryClr,
                                fontSize: 40,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "${providerF.tasks.length} tasks",
                              style: TextStyle(
                                color: primaryClr,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: MaterialButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => SingleChildScrollView(
                                          child: Container(
                                        color: primaryClr,
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: bottomSheet(),
                                      )));
                            },
                            child: CircleAvatar(
                              radius: 30,
                              child: Icon(
                                Icons.add,
                                color: secondaryClr,
                              ),
                              backgroundColor: primaryClr,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                      child: TaskListView(),),
                ],
              ),
            ),
          );

  }
}
