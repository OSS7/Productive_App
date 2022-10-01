import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:productivity_local/constant.dart';
import 'package:productivity_local/setting/providers/setting_data.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<int> colors = [
    0xffb71c1c,
    0xff0d47a1,
    0xff827717,
    0xff4a148c,
    0xff004d40,
  ];


  Widget _buildSwitchListTile(
      {required String Title,
        required String Description,
        required bool CurrentValue,
        required Function(bool?)? UpdateState}) {
    return SwitchListTile(
      title: Text(Title,style: TextStyle(
        color: secondaryClr,
      ),),
      subtitle: Text(Description,style: TextStyle(
        color: secondaryClr,
      ),),
      value: CurrentValue,
      onChanged: UpdateState!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingData>(context);
    final size = MediaQuery.of(context).size;
    final box = GetStorage();
    return Scaffold(
      backgroundColor: secondaryClr,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            color: secondaryClr,
            width: double.infinity,
            padding: const EdgeInsets.only(
                left: 45, top: 30, right: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 30,
                  child: Icon(
                    Icons.settings,
                    size: 35,
                    color:secondaryClr,
                  ),
                  backgroundColor: primaryClr,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Setting',
                  style: TextStyle(
                    color: primaryClr,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(30),
              // height: 50,
              decoration:  BoxDecoration(
                color: primaryClr,
                gradient: LinearGradient(
                  colors: [primaryClr, primaryClr],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView(
                children: [
                  _buildSwitchListTile(
                      Title: "Dark mode",
                      Description: "enable dark mode",
                      CurrentValue: box.read('mode')??false,
                      UpdateState: (newValue) {
                        setState(() {
                          if(newValue == true){
                            primaryClr = Colors.black;
                            // kWhite = Colors.white;
                            box.write('mode', true);
                          }
                          else{
                            primaryClr = Colors.white;
                            // kWhite = Colors.black;
                            box.write('mode', false);
                          }
                        });
                      }),
                  const SizedBox(height: 40
                    ,),
                  Container(
                    // color: secondaryClr,
                    height: 100,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.c,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text('Choose primary color',style: TextStyle(color: secondaryClr),)),

                        Center(
                          child: SizedBox(
                            // color: Colors.purple,
                              height: 50,
                              width: 400,
                              // alignment: Alignment.center,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: colors.length,
                                  itemBuilder: (context,i){
                                    return MaterialButton(
                                      // color: selected == i ? Colors.black45 : Colors.white,
                                      onPressed: (){

                                        setState(() {
                                          // selected = i;
                                          secondaryClr = Color(colors[i]);
                                          box.write('color', colors[i]);
                                        });
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Color(colors[i]),
                                      ),
                                    );
                                  })
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
            ),
          ),

          ),
        ],
      ),
    );
  }
}
