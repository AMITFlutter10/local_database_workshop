import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_database_workshop/const.dart';
import 'package:local_database_workshop/view/widgets/default_form_filed.dart';
import 'package:local_database_workshop/view/widgets/default_text.dart';
import 'package:sizer/sizer.dart';
import '../../note_cubit/notes_cubit.dart';

class ShowNotes extends StatelessWidget {
  const ShowNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
     builder: (context, state) {
    return Scaffold(
      body: NotesCubit.get(context).screens[NotesCubit.get(context).currentIndex],
      // SafeArea(
      //   child: Padding(
      //     padding:  EdgeInsets.all(2.h),
      //     child: ListView.separated(
      //         separatorBuilder: (context, index) => SizedBox(
      //               height: 2.h,
      //             ),
      //         itemCount: noteList.length,
      //         itemBuilder: (context, index) => Items(
      //               item: noteList[index],
      //             )),
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: NotesCubit.get(context).currentIndex,
        onTap: (index) {
          NotesCubit.get(context).changeNavBar(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.note_add), label: "Note"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite")
        ],
      ),
    );
  },
);
  }
}
class Note extends StatelessWidget {
  const Note({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(2.h),
            child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                      height: 2.h,
                    ),
                itemCount: NotesCubit.get(context).noteList.length,
                itemBuilder: (context, index) => Items(
                      item: NotesCubit.get(context).noteList[index],
                    )),
          ),
        );
      },
    );
  }
}

class Items extends StatelessWidget {
  Map item;
  Items({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Dismissible(
      key: UniqueKey(),
      onDismissed: (dismissed) {
        NotesCubit.get(context).deleteDatabase(id: item['id']);
        Fluttertoast.showToast(
            msg: "Deleted",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      },
      child: InkWell(
        onTap: (){
          Fluttertoast.showToast(
              msg: "Long touch for Note editing, Swipe left or right to delete,",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        },
        onLongPress: (){
          showDialog(context: context, builder: (context)=> EditNote(notes:item ,));
        },
        child: Container(
          padding: EdgeInsets.all(2.h),
          width: 80.w,
          height: 13.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.grey[300]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    text: item["title"],
                    fontSize: 15.sp,
                  ),
                  DefaultText(
                    text: item["message"],
                    fontSize: 13.sp,
                  ),
                ],
              ),
              Visibility(
                  visible: item["favorite"] == "Y",
                  replacement: IconButton(
                      onPressed: () {
                        NotesCubit.get(context)
                            .updateFavorite(id: item['id'], favorite: "Y");
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                      )),
                  child: IconButton(
                      onPressed: () {
                        NotesCubit.get(context)
                            .updateFavorite(id: item['id'], favorite: "N");
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )))
            ],
          ),
        ),
      ),
    ));
  }
}
class EditNote extends StatelessWidget {
  Map notes;
  EditNote({super.key,required this.notes});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child:  Column(
            children: [
              DefaultFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                hintText: "Title",

              ),
              SizedBox(height: 3.h,),
              DefaultFormField(controller: messageController,
                  keyboardType: TextInputType.text,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){
                    NotesCubit.get(context).updateDataBase(id: notes['id'],
                        message: messageController.text,
                        title:titleController.text );
                    Navigator.pop(context);
                  }, child: DefaultText(text: "Save",)),
                  TextButton(onPressed: (){
                    Navigator.pop(context);

                  }, child: DefaultText(text: "Cancel",))
                ],
              )
            ],
          ),
        ),
    );
  }
}
