import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_database_workshop/data_base/local.dart';
import 'package:local_database_workshop/view/widgets/default_text.dart';
import 'package:sizer/sizer.dart';

import 'favorite_page.dart';

class ShowNotes extends StatefulWidget {
  const ShowNotes({super.key});

  @override
  State<ShowNotes> createState() => _ShowNotesState();
}
int currentIndex=0;
List<Widget>screens =[
  Note(),
  ShowFavorite(),
];

class _ShowNotesState extends State<ShowNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
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
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex= index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.note_add), label:"Note" ),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label:"Favorite")
        ],

      ),

    );
  }
}
class Note extends StatelessWidget {
  const Note({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:  EdgeInsets.all(2.h),
        child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(
              height: 2.h,
            ),
            itemCount: noteList.length,
            itemBuilder: (context, index) => Items(
              item: noteList[index],
            )),
      ),
    );
  }
}


class Items extends StatefulWidget {
  Map item;
  Items({super.key, required this.item});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (dismissed){
            setState(() {
            deleteDatabase(id: widget.item['id']);
            Fluttertoast.showToast(
                msg: "Deleted",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
            });
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
                  text: widget.item["title"],
                  fontSize: 15.sp,
                ),
                DefaultText(
                  text: widget.item["message"],
                  fontSize: 13.sp,

                ),
              ],
            ),
            Visibility(
              visible: widget.item["favorite"]=="Y" ,
                replacement: IconButton(onPressed: () {
                  setState(() {
                  updateFavorite(id: widget.item['id'], favorite: "Y");  });
                },
                    icon: Icon(Icons.favorite_border ,color: Colors.grey,)),
                child: IconButton(onPressed: () {
                  setState(() {
                  updateFavorite(id: widget.item['id'], favorite: "N");  });
                },
                    icon: Icon(Icons.favorite ,color: Colors.red,)))
          ],
      ),
    ),
        ));
  }
}
