import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_database_workshop/note_cubit/notes_cubit.dart';
import 'package:local_database_workshop/view/screens/home_page.dart';
import 'package:sizer/sizer.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_)=> NotesCubit()..createDataBase()
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home:  HomePage()
        ),
      );
      }
    );
  }
}
