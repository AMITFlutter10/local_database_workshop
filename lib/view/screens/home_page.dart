import 'package:flutter/material.dart';
import 'package:local_database_workshop/data_base/local.dart';
import 'package:local_database_workshop/view/screens/favorite_page.dart';
import 'package:local_database_workshop/view/screens/show_notes.dart';
import 'package:local_database_workshop/view/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import '../widgets/default_form_filed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
var titleController= TextEditingController();
var messageController= TextEditingController();

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    createDataBase();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(2.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  DefaultFormField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    height: 10.h,
                    hintText: "Title",
                  ) ,
                  SizedBox(
                    height: 1.h,
                  ),
                  DefaultFormField(
                    controller: messageController,
                    keyboardType: TextInputType.text,
                    height: 10.h,
                    hintText: "message",
                  ),
                ],
              ),
            ),
            ElevatedButton(onPressed: (){
              insertDataBase(title:titleController.text , message:messageController.text );
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowNotes()));
            }, child: DefaultText(
              text: "Add Note",
            ))
          ],
        ),
      ),
    );
  }
}
