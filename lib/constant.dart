import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

final box = GetStorage();

Color primaryClr = box.read('mode') == true ? Colors.black : Colors.white;
// Color kWhite = box.read('mode') == true ? Colors.white : Colors.black;

Color secondaryClr =  Colors.purple;