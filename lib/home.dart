import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/register.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white),
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Login()),
                            );
                          },
                          icon: Icon(Icons.arrow_back,color: Colors.orangeAccent[400],size: 40,))
                    ],
                  ),
                  SizedBox(height: 200,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Text(
                        'Home',
                        style: TextStyle(
                          color: Colors.orangeAccent[400],
                          fontSize: 50,
                        ),
                      ),
                      SizedBox(height: 20,),
                      // StreamBuilder(
                      //   stream: FirebaseAuth.instance.getRedirectResult(),
                      //   builder: ((context, snapshot) {
                      //     if(snapshot.hasData){
                      //       return ListView.builder(
                      //           itemCount:snapshot.data!.length,
                      //           // AppCubit().users[AppCubit().currentIndex].length,
                      //           // AppCubit.get(context).allUsers().toString().length,
                      //           itemBuilder: (BuildContext context, int index) {
                      //             return Card(
                      //               child: ListTile(
                      //                 leading: Text(
                      //                   '${snapshot.data![index]['id']}',
                      //                 ),
                      //                 trailing: IconButton(onPressed: () async{
                      //                   await AppCubit.get(context).deleteDate(id:snapshot.data![index]['id']);
                      //                 }, icon: Icon(Icons.delete_outline),),
                      //                 subtitle:  Column(
                      //                   mainAxisAlignment: MainAxisAlignment.start,
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       '${snapshot.data![index]['email']}',
                      //                     ),
                      //                     Text(
                      //                       '${snapshot.data![index]['password']}',
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 title: Row(
                      //                   children: [
                      //                     // Image(image: FileImage(snapshot.data![index]['img'])),
                      //                     Text('${snapshot.data![index]['username']}',style: TextStyle(fontSize: 20.sp),),
                      //                   ],
                      //                 ),
                      //               ),
                      //             );
                      //           });}
                      //     return CircularProgressIndicator();
                      //   }
                      //   ),
                      // ),
                      ElevatedButton(
                        onPressed: (){
                          FirebaseAuth.instance.signOut().then((value){
                            print("Signed Out");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Login()),
                            );
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orangeAccent[400],
                          shadowColor:Colors.orangeAccent[400],
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          fixedSize: Size(120, 40),
                        ),
                        child: Text("Logout",style: TextStyle(fontSize: 17),),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
