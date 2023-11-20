part of 'notes_cubit.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}
class ChangeNavBarState extends NotesState {}
class InsertDataBaseSuccessState extends NotesState {}
class UpdateDataBaseSuccessState extends NotesState {}
class UpdateFavoriteDataBaseSuccessState extends NotesState {}
class DeleteDataBaseSuccessState extends NotesState {}
/////////////////////////
class LoadingDataSuccessState extends NotesState {}
class GetDataSuccessState extends NotesState {}
class ErrorDataSuccessState extends NotesState {}
