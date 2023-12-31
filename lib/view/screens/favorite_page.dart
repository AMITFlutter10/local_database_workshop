import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_database_workshop/view/screens/show_notes.dart';
import 'package:sizer/sizer.dart';
import '../../note_cubit/notes_cubit.dart';

class ShowFavorite extends StatefulWidget {
  const ShowFavorite({super.key});

  @override
  State<ShowFavorite> createState() => _ShowFavoriteState();
}

class _ShowFavoriteState extends State<ShowFavorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(2.h),
              child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                        height: 2.h,
                      ),
                  itemCount: NotesCubit.get(context).favoriteList.length,
                  itemBuilder: (context, index) => Items(
                        item: NotesCubit.get(context).favoriteList[index],
                      )),
            ),
          );
        },
      ),
    );
  }
}
