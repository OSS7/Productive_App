import 'package:flutter/material.dart';
import 'package:productivity_local/constant.dart';

class TaskTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final bool? isChecked;
  Function(bool?)? onChanged;
  final Function()? onLongPress;
  TaskTile({this.title,
    this.isChecked,
    this.onChanged,
    this.onLongPress, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Text('$subtitle',style: TextStyle(
        color:  secondaryClr,
      ),),
      onLongPress: onLongPress,
      title: Text(
        title??'null',
        style: TextStyle(fontSize: 25,color: secondaryClr,decoration: isChecked! ? TextDecoration.lineThrough:null,fontWeight: FontWeight.bold),),
      trailing: Checkbox(checkColor: primaryClr,focusColor: primaryClr,side: BorderSide(
        color: secondaryClr
      ),activeColor: secondaryClr,value: isChecked, onChanged: onChanged),
    );
  }
}

