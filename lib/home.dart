import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database/cubit.dart';
import 'database/states.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var todoName = TextEditingController();
  var todoContent = TextEditingController();
  var date = TextEditingController();
  final DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..createDatebase(),
        child: BlocConsumer<AppCubit,AppStates>(
        listener: ( context , state){
          if(state is AppInsertDateBaseState){}
          },
          builder: (BuildContext context, state)
          {
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 50,
                shadowColor: Colors.transparent,
                // backgroundColor: Theme.of(context).primaryColor,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xFF8A2387),
                        Color(0xFFE94057),
                        Color(0xFFF27121),
                      ])
                  ),
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                title: const Text('My Todos'),
              ),
              drawer: Drawer(
                  child: Padding(
                    padding: const EdgeInsets.only(left:10, top: 50),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Theme
                                    .of(context)
                                    .primaryColor,
                                child: const Icon(
                                  Icons.person_outline, size: 90, color: Colors.white,),
                              ),
                              SizedBoxPadding(10).sh,
                              Text('${FirebaseAuth.instance.currentUser!.email}',
                                style: TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme
                                        .of(context)
                                        .primaryColor),),
                            ],
                          ),
                        ),
                        SizedBoxPadding(10).sh,
                        const Divider(endIndent: 20,indent: 10,),
                        SizedBoxPadding(10).sh,
                        SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.list_alt, color: Theme
                                      .of(context)
                                      .primaryColor,),
                                  title: const Text('My Todos'),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()),
                                    );
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.delete_outline, color: Theme
                                      .of(context)
                                      .primaryColor,),
                                  title: const Text('Trash'),
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => const Home()),
                                    // );
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.logout, color: Theme
                                      .of(context)
                                      .primaryColor,),
                                  title: const Text('Logout'),
                                  onTap: () {
                                    FirebaseAuth.instance.signOut().then((value) {
                                      print("Signed Out");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const Login()),
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ),
              body: ConditionalBuilder(
                condition:  state is! AppGetDateBaseLoadinState,
                fallback: (contaxt)=>const Center(child: CircularProgressIndicator(),),
                builder:(context) => Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xFF8A2387),
                        Color(0xFFE94057),
                        Color(0xFFF27121),
                      ])),
                  child: Padding(
                    padding: const EdgeInsets.only(top:40),
                    child: FutureBuilder(
                      future: AppCubit.get(context).allTodos(),
                      builder: (context,snapshot) {
                        if(snapshot.hasData){
                        return Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                  itemBuilder: (ctx, i)=>
                                    Dismissible(
                                      key: UniqueKey(),
                                      direction : DismissDirection.endToStart,
                                      onDismissed: (a)async{
                                        await AppCubit.get(context).deleteDate(id: snapshot.data![i]['id']);
                                        print('${i + 1} Deleted');
                                      },
                                      background: Container(
                                          alignment: AlignmentDirectional.centerEnd,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Color(0xFF8A2387),
                                              Color(0xFFE94057),
                                              Color(0xFFF27121),
                                            ]),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(20, 0.0,20, 0.0),
                                            child: Icon(Icons.delete,
                                              color: Colors.white,
                                            ),
                                          ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20,right: 20),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              leading: Text('${i+1}'),
                                              title: Text('${snapshot.data![i]['todoname']}'),
                                              // subtitle: Text('${snapshot.data![i]['content']}'),
                                              trailing: Text('${snapshot.data![i]['date']}'),
                                              onTap: (){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => ThisTodo(id: i,)),
                                                );
                                              },
                                              ),
                                            Container(
                                              height: 1,
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(colors: [
                                                    Color(0xFF8A2387),
                                                    Color(0xFFE94057),
                                                    Color(0xFFF27121),
                                                  ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                              ),
                            )
                        );}
                        return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
                        }
                        ),
                        ),
                  ),
                ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme
                    .of(context)
                    .primaryColor,
                child: const Icon(Icons.add),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) =>
                          StatefulBuilder(
                              builder: (ctx, state) {
                                return AlertDialog(
                                  title: const Text('New Todo'),
                                  titleTextStyle: TextStyle(color: Theme
                                      .of(context)
                                      .primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  contentPadding: const EdgeInsets.all(20),
                                  content: SingleChildScrollView(
                                    child: Container(
                                      height: 200,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: todoName,
                                            cursorColor: Theme
                                                .of(context)
                                                .primaryColor,
                                            decoration: InputDecoration(
                                                labelText: 'Todo Name',
                                                labelStyle: TextStyle(color: Theme
                                                    .of(context)
                                                    .hintColor),
                                                suffixIcon: IconButton(
                                                  icon: const Icon(Icons.clear),
                                                  color: Theme
                                                      .of(context)
                                                      .primaryColor,
                                                  onPressed: () {
                                                    todoName.clear();
                                                  },),
                                                enabledBorder: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(25)),
                                                ),
                                                focusedBorder: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(25)),
                                                )
                                            ),
                                          ),
                                          SizedBoxPadding(10).sh,
                                          TextFormField(
                                            controller: todoContent,
                                            // maxLength: 20,
                                            minLines: 1,
                                            cursorColor: Theme
                                                .of(context)
                                                .primaryColor,
                                            decoration: InputDecoration(
                                                labelText: 'Todo Content',
                                                labelStyle: TextStyle(color: Theme
                                                    .of(context)
                                                    .hintColor),
                                                suffixIcon: IconButton(
                                                  icon: const Icon(Icons.clear),
                                                  color: Theme
                                                      .of(context)
                                                      .primaryColor,
                                                  onPressed: () {
                                                    todoContent.clear();
                                                  },),
                                                enabledBorder: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(25)),
                                                ),
                                                focusedBorder: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(25)),
                                                )
                                            ),
                                          ),
                                          SizedBoxPadding(10).sh,
                                          TextFormField(
                                            controller: date,
                                            cursorColor: Theme
                                                .of(context)
                                                .primaryColor,
                                            onTap: () async {
                                              DateTime? newDate = await showDatePicker(
                                                  context: context,
                                                  initialDate: _date,
                                                  firstDate: DateTime(1940),
                                                  lastDate: DateTime(2040),
                                                  builder: (context, child) {
                                                    return Theme(
                                                      data: Theme.of(context).copyWith(
                                                        colorScheme: ColorScheme.light(
                                                          primary: Theme
                                                              .of(context)
                                                              .primaryColor,
                                                          onPrimary: Colors.white,
                                                          onSurface: Theme
                                                              .of(context)
                                                              .primaryColor,
                                                        ),
                                                        textButtonTheme: TextButtonThemeData(
                                                          style: TextButton.styleFrom(
                                                            foregroundColor: Theme
                                                                .of(context)
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                      child: child!,
                                                    );
                                                  });
                                              if (newDate == null) return;
                                              setState(() {
                                                String dateFormat = DateFormat(
                                                    "yyyy-MM-dd").format(newDate);
                                                date.text = dateFormat;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                labelText: 'Todo Date',
                                                labelStyle: TextStyle(color: Theme
                                                    .of(context)
                                                    .hintColor),
                                                prefixIcon: Icon(
                                                  Icons.calendar_month_rounded,
                                                  color: Theme
                                                      .of(context)
                                                      .primaryColor,),
                                                suffixIcon: IconButton(
                                                  icon: const Icon(Icons.clear),
                                                  color: Theme
                                                      .of(context)
                                                      .primaryColor,
                                                  onPressed: () {
                                                    date.clear();
                                                  },),
                                                enabledBorder: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(25)),
                                                ),
                                                focusedBorder: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(25)),
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            onPressed: ()async{
                                              await AppCubit.get(context).insertToDatebase(
                                                  todoname: todoName.text,
                                                  content: todoContent.text,
                                                  date: date.text
                                              );
                                              Navigator.of(context).pop();
                                              state((){
                                                todoContent.clear();
                                                todoName.clear();
                                                date.clear();
                                              });
                                              },
                                            style: TextButton.styleFrom(foregroundColor: Colors.orange),
                                            child: Text(
                                              'Save', style: TextStyle(color: Theme
                                                .of(context)
                                                .primaryColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),)
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: TextButton.styleFrom(foregroundColor: Colors.orange),
                                            child: Text(
                                              'Cancel', style: TextStyle(color: Theme
                                                .of(context)
                                                .hintColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),)
                                        )
                                      ],
                                    )
                                  ],
                                );
                              }
                          )
                  );
                },
              ),
      );
    }
    )
    );
  }
}
extension SizedBoxPadding on num {
  SizedBox get sh => SizedBox(height: toDouble(),);
  SizedBox get sw => SizedBox(width: toDouble(),);
}
