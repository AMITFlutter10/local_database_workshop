import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../view/screens/favorite_page.dart';
import '../view/screens/show_notes.dart';
part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  static NotesCubit get(context)=> BlocProvider.of(context);

int currentIndex=0;
List<Widget>screens = const [
   Note(),
   ShowFavorite(),
];

changeNavBar(int index){
  currentIndex =index;
  emit(ChangeNavBarState());
}

  late Database database;
   // crud

 createDataBase()async{
   //  Get a location using getDatabasesPath
   var databasesPath = await getDatabasesPath();
   print(databasesPath);
   // /data/user/0/com.example.local_database_workshop/databases/
   String path = join(databasesPath,"note.db");
    print(path);
   // /data/user/0/com.example.local_database_workshop/databases/note.db
 database = await openDatabase(path,version: 1,
    onCreate: (db, version){
     db.execute('CREATE TABLE Note (id INTEGER PRIMARY KEY, title TEXT,message TEXT , favorite TEXT)').
     then((value) {
       print(" table created");
     }).catchError((error){
       print(error);
         });
    },
    onOpen: (db){
    getDataBase(db);
     print("Database opened");
   });
 }
 insertDataBase({required String title, required String message})async{
   await database.transaction((txn) {
     return txn.rawInsert('INSERT INTO Note(title, message ,favorite) VALUES("$title","$message" ,"N" )')
         .then((value) {
       print("$value record inserted");
       emit(InsertDataBaseSuccessState());
       getDataBase(database);
     }).catchError((error){
       print(error);
     });
   });
 }

 updateDataBase({required int id ,required String title,required String message})async{
           await database.rawUpdate('UPDATE Note SET title = ?, message = ? WHERE id = ?',
               [title, message, id])
               .then((value) {
                 print("$value update");
                 getDataBase(database);
                 emit(UpdateDataBaseSuccessState());
           }).catchError((error){
             print(error);
           });
          }

 updateFavorite({required int id ,required String favorite})async{
   await database.rawUpdate('UPDATE Note SET favorite = ? WHERE id = ?',
       [favorite, id])
       .then((value) {
     print("$value update");
     getDataBase(database);
     emit(UpdateFavoriteDataBaseSuccessState());
   }).catchError((error){
     print(error);
   });
 }
 deleteDatabase({required int id })async{
   await database.rawDelete('DELETE FROM Note WHERE id = ?', [id]).then((value) {
     print("$value is deleted");
     getDataBase(database);
     emit(DeleteDataBaseSuccessState());
   }).catchError((error){
     print(error);
   });
 }

 List<Map>noteList=[];
 List<Map>favoriteList=[];

 getDataBase(database){
   noteList.clear();
   favoriteList.clear();
   emit(LoadingDataSuccessState());
   database.rawQuery('SELECT * FROM Note').then((value){
     for(Map<String, Object?> element in value ){
       noteList.add(element);
       if(element['favorite']=="Y"){
         favoriteList.add(element);
       }
     }
     emit(GetDataSuccessState());
   }).catchError((error){
     emit(ErrorDataSuccessState());
     print(error);
   });
 }

}
