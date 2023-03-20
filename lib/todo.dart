import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'database/cubit.dart';
import 'database/states.dart';
class ThisTodo extends StatefulWidget {
  const ThisTodo({Key? key,required this.id}) : super(key: key);
    final int id ;
  @override
  State<ThisTodo> createState() => _ThisTodoState();
}

class _ThisTodoState extends State<ThisTodo> {

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
              title: const Text('Todo'),
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
                                              padding: const EdgeInsets.only(top:40,left: 20,right: 20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text('${snapshot.data![widget.id]['date']}'),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text('${snapshot.data![widget.id]['todoname']}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20,),
                                                  Row(
                                                    children: [
                                                      Text('${snapshot.data![widget.id]['content']}',style: TextStyle(fontSize: 20,)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                              );}
                                return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
              }
          )))),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme
                  .of(context)
                  .primaryColor,
              child: const Icon(Icons.edit),
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
                                    child: FutureBuilder(
                                      future: AppCubit.get(context).allTodos(),
                                      builder: (context,snapshot) {
                                        if(snapshot.hasData){
                                        return Column(
                                          children: [
                                            TextFormField(
                                              controller: todoName..text = '${snapshot.data![widget.id]['todoname']}',
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
                                              controller: todoContent..text = '${snapshot.data![widget.id]['content']}',
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
                                              controller: date..text = '${snapshot.data![widget.id]['date']}',
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
                                        );}
                                        return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
                                      }
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
                                            await AppCubit.get(context).updateData(id: widget.id);
                                            Navigator.of(context).pop();
                                            state((){
                                              todoContent.clear();
                                              todoName.clear();
                                              date.clear();
                                            });
                                          },
                                          style: TextButton.styleFrom(foregroundColor: Colors.orange),
                                          child: Text(
                                            'Update', style: TextStyle(color: Theme
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
