import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:productivity_local/constant.dart';
import 'package:productivity_local/task/models/task.dart';
import 'package:productivity_local/task/provider/task_data.dart';
import 'package:provider/provider.dart';

class bottomSheet extends StatefulWidget {
  @override
  State<bottomSheet> createState() => _bottomSheetState();
}

class _bottomSheetState extends State<bottomSheet> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskData>(context, listen: false);
    String? titleValue;
    String? subtitleValue;
    return Container(
      decoration:  BoxDecoration(
        color: primaryClr,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.only(right: 35, left: 35, top: 25, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Add task",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: secondaryClr, fontSize: 25, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 40,
          ),
          TextField(
            decoration: InputDecoration(
              label: Text('Title'),
              labelStyle: TextStyle(
                  color: secondaryClr
              ),
              focusedBorder: OutlineInputBorder(

                borderSide: BorderSide(color: secondaryClr, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: secondaryClr, width: 1),
              ),
            ),
            style:  TextStyle(color: secondaryClr),
            onChanged: (newValue) {
              titleValue = newValue;
            },
            cursorColor: secondaryClr,
            autofocus: true,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
              label: Text('Subtitle'),
              labelStyle: TextStyle(
                  color: secondaryClr
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: secondaryClr, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: secondaryClr, width: 1),
              ),
            ),
            style:  TextStyle(color: secondaryClr),
            onChanged: (newValue) {
              subtitleValue = newValue;
            },
            cursorColor: secondaryClr,
            autofocus: true,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {
              provider.addTask(titleValue ?? 'null',subtitleValue??'null');

              setState(() {});
              Navigator.pop(context);
            },
            color: secondaryClr,
            child: const Text(
              "Add",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
