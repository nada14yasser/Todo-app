// import 'package:firebaseauth/database/states.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AppCubit extends Cubit<AppStates>
// {
//   AppCubit() : super(AppInitialState());
//
//   static AppCubit get(Context)=> BlocProvider.of(Context);
//
//   void createDatebase()async
//   {
//     FirebaseFirestore.instance.collection("todos");
//     FirebaseFirestore.instance.collection("todos");
//   }
//   Future getAllUsers()async{
//     final snapshot= await FirebaseFirestore.instance.collection("users").get();
//     return snapshot.docs;
//   }
//   signUp({
//     required String username,
//     required String email,
//     required String password,
//   })async{
//     var database = FirebaseFirestore.instance.collection("users");
//     var users = await database.get();
//     int index =users.docs.indexWhere((element) {
//       return element.data()["name"] == username;
//     });
//     if(index==-1){
//       FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: email,
//           password: password).then((value)async{
//         await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
//         print("Account Created");
//         await insertToDatebase(username: username, email: email, password: password,);
//       }).onError((error, stackTrace) {
//         print("Error ${error.toString()}");
//       });
//     }
//   }
//
//   insertToDatebase({
//     required String username,
//     required String email,
//     required String password,
//   }) async
//   {
//     var database = FirebaseFirestore.instance.collection("users");
//     await database.add({
//       "name":username,
//       "email":email,
//       "password":password,
//     });
//   }
//   insertTodo({
//     required int id,
//     required String todoName,
//     required String todoContent,
//     required String todoDate,
//   }) async
//   {
//     var database = FirebaseFirestore.instance.collection("todos");
//     await database.add({
//       'id':id,
//       "todoname":todoName,
//       "todocontent":todoContent,
//       "date":todoDate,
//     });
//   }
//   // Future updateUsers()async{
//   //   final snapshot= await FirebaseFirestore.instance.collection("users").get();
//   //   return snapshot.docs;
//   // }
//
//   // Future<List> allUsers()async{
//   //   List<Map> list = await database.query("users");
//   //   // print(list[0]['username']);
//   //   return list;
//   // }
//
// }

import 'package:bloc/bloc.dart';
import 'package:firebaseauth/database/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
// class AppCubit extends Cubit<AppStates>
// {
//   AppCubit() : super(AppInitialState());
//   static AppCubit get(Context)=> BlocProvider.of(Context);
//   late Database database;
//   int currentIndex=0;
//   List<Map> newtasks = [];
//   List<Map> donetasks = [];
//   List<Map> archivedtasks = [];
//   List<String> titles=
//   [
//     'New Tasks',
//     'Done Tasks',
//     'Archaived Tasks',
//   ];
//   // List<Widget> screens =
//   // [
//   //   new_tasks_screen(),
//   //   done_tasks_screen(),
//   //   archaived_tasks_screen()
//   // ];
//   void createDatebase()
//   {
//     openDatabase(
//         'todo.db',
//         version: 1,
//         onCreate: (database, version)
//         {
//           print('DataBase Created');
//           database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT , date TEXT, content TEXT, status TEXT)').then((value)
//           {
//             print('Table Created');
//           }).catchError((error){
//             print('Error when creating table ${error.toString()}');
//           });
//         },
//         onOpen: (database)
//         {
//           getDataFromDatabase(database);
//           print('DataBase opened');
//
//         }
//     ).then((value) {
//       database = value;
//       emit(AppCreateDateBaseState());
//     });
//   }
//   insertToDatebase({
//     required String title,
//     required String content,
//     required String date,
//   }) async
//   {
//     await database.transaction((txn) async
//     {
//       txn.rawInsert('INSERT INTO tasks(title, date , content , status) VALUES("$title","$date","$content","NEW")').then((value)
//       {
//         print('$value inserted sussafuly');
//         emit(AppInsertDateBaseState());
//
//         getDataFromDatabase(database);
//       })
//           .catchError((error){
//         print('Error Inserting Table ${error.toString()}');
//       });
//     });
//
//   }
//
//   void getDataFromDatabase(database)
//   {
//     newtasks=[];
//     donetasks=[];
//     archivedtasks=[];
//
//     emit(AppGetDateBaseLoadinState());
//     database.rawQuery('SELECT * FROM tasks').then((value)
//     {
//       value.forEach((element) {
//         if(element['status']=='NEW')
//           newtasks.add(element);
//         // print(element['status']);
//         else if(element['status']=='done')
//           donetasks.add(element);
//         else archivedtasks.add(element);
//       }
//       );
//       emit(AppGetDateBaseState());
//     });
//
//   }
//
//   void updateData({
//     required String status,
//     required int id,
//   }) async
//   {
//     database.rawUpdate(
//         'UPDATE tasks SET status = ? WHERE id = ?',
//         ['$status', id]
//     ).then((value)
//     {
//       getDataFromDatabase(database);
//       emit(AppUpdateDateBaseLoadinState());
//
//     }
//     );
//
//   }
//   void deleteDate({
//     required id
//   })
//   {
//     database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value)
//     {
//       getDataFromDatabase(database);
//       emit(AppDeleteDateBaseLoadinState());
//     });
//   }
//
//   getTodo()async{
//     var todoData = await database.rawQuery('SELECT * FROM tasks');
//     return todoData;
//   }
// }

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());
  static AppCubit get(Context)=> BlocProvider.of(Context);
  late Database database;
  List<Map> todos = [];
  List<Map> todoCreate = [];

  void createDatebase()
  {
    openDatabase(
      'todo.db',
      version: 1,

      onCreate: (database, version)
      {
        print('DataBase Created');
        database.execute('CREATE TABLE todos (id INTEGER PRIMARY KEY, todoname TEXT , content TEXT, date TEXT)').then((value)
        {
          print('Table Created');
        }).catchError((error){
          print('Error when creating table ${error.toString()}');
        });
      },
      onOpen: (database)
      {
        getDataFromDatabase(database);
        print('DataBase opened');
        // print('columns added');
      },
    ).then((value) {
      database = value;
      print(database.path);
      emit(AppCreateDateBaseState());
    });
  }
  insertToDatebase({
    required String todoname,
    required String content,
    required String date,
  }) async
  {
    await database.transaction((txn) async
    {
      txn.rawInsert('INSERT INTO todos(todoname, content , date) VALUES("$todoname","$content","$date")').then((value)
      {
        print('$value inserted sussafuly');
        emit(AppInsertDateBaseState());

        getDataFromDatabase(database);
      })
          .catchError((error){
        print('Error Inserting Table ${error.toString()}');
      });
    });

  }

  getDataFromDatabase(database)
  {
    todos=[];

    emit(AppGetDateBaseLoadinState());
    database.rawQuery('SELECT * FROM todos').then((value)
    {
      value.forEach((element) {
        todos.add(element);
      }
      );
      emit(AppGetDateBaseState());
    });

  }

  updateData({
    required int id,
  }) async
  {
    database.rawUpdate(
        // 'UPDATE todos WHERE id = ?',
        'UPDATE todos SET todoname = ?, content = ?, date = ? WHERE id = ?'
        [id]
    ).then((value)
    {
      getDataFromDatabase(database);
      emit(AppUpdateDateBaseLoadinState());
    }
    );

  }

  deleteDate({
    required id
  })
  {
    database.rawDelete('DELETE FROM todos WHERE id = ?', [id]).then((value)
    {
      print("$id");
      getDataFromDatabase(database);
      emit(AppDeleteDateBaseLoadinState());
    });
  }

  Future<List> allTodos()async{
    List<Map> list = await database.query("todos");
    // print(list[0]['todoname']);
    return list;
  }

}


