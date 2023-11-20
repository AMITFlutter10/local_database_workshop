import 'package:flutter/material.dart';
import 'package:local_database_workshop/view/screens/show_notes.dart';
import 'package:sizer/sizer.dart';

import '../../data_base/local.dart';

class ShowFavorite extends StatefulWidget {
  const ShowFavorite({super.key});

  @override
  State<ShowFavorite> createState() => _ShowFavoriteState();
}

class _ShowFavoriteState extends State<ShowFavorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(2.h),
          child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 2.h,
              ),
              itemCount: favoriteList.length,
              itemBuilder: (context, index) => Items(
                item: favoriteList[index],
              )),
        ),
      ),
    );
  }
}