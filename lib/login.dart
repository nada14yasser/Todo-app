import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/register.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formkey = GlobalKey< FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final nameFocusNode = FocusNode();
  bool _obscured = true;
  //validation and save button
  bool isButtonActiveEmail = false;
  bool isButtonActivePass = false;
  var erroremail = '';
  var errorpass = '';
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (passwordFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      passwordFocusNode.canRequestFocus = false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color(0xFF8A2387),
                    Color(0xFFE94057),
                    Color(0xFFF27121),
                  ])),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 120,
                    ),
                    const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Form(
                      key: formkey,
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width:300 ,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: const BorderRadius.all(Radius.circular(25)),
                              ),
                              child: TextFormField(
                                controller: emailController,
                                cursorColor: Colors.grey,
                                onChanged: (val)async {
                                  isButtonActiveEmail = formkey
                                      .currentState!
                                      .validate();
                                  isButtonActiveEmail
                                      ? setState(() {})
                                      : null;
                                },
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)) {
                                    // return "name is required";
                                  }
                                  else {
                                    setState(() {
                                      erroremail = 'n';
                                    });
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  errorStyle:
                                  TextStyle(
                                    color: erroremail==''?Colors.red:Colors.green,),
                                  contentPadding:
                                  const EdgeInsets.all(20),
                                  hintText: "email",
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15),
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        emailController.clear();
                                        setState(() {
                                          emailController.text = '';
                                        });
                                      },
                                      child: Icon(
                                        erroremail==''
                                            ? Icons.close
                                            : Icons.done,
                                        size: 20,
                                        color:  erroremail==''
                                            ? Colors.redAccent
                                            : Colors.green.shade400,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    borderSide:
                                    erroremail=='n'?
                                    const BorderSide(
                                        color: Colors.green)
                                        : const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    borderSide:
                                    erroremail=='n'
                                        ? const BorderSide(
                                        color: Colors.green):
                                    const BorderSide(
                                        color: Colors.grey),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    borderSide:
                                    erroremail=='n'
                                        ? const BorderSide(
                                        color: Colors.green):
                                    const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    borderSide:
                                    erroremail=='n'?
                                    const BorderSide(
                                        color: Colors.green)
                                        : const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                ),
                              )
                          ),
                          SizedBox(height: 20,),
                          Container(
                            width:300 ,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: const BorderRadius.all(Radius.circular(25)),
                              ),
                              child: TextFormField(
                                controller: passwordController,
                                cursorColor: Colors.grey,
                                onChanged: (val)async {
                                  isButtonActivePass = formkey
                                      .currentState!
                                      .validate();
                                  isButtonActivePass
                                      ? setState(() {})
                                      : null;
                                },
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                          .hasMatch(value)) {
                                    // return "password is required";
                                  } else {
                                    setState(() {
                                      errorpass = 'n';
                                    });
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  errorStyle:
                                  TextStyle(
                                    color: errorpass==''?Colors.red:Colors.green,),
                                  contentPadding:
                                  const EdgeInsets.all(20),
                                  hintText: "password",
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15),
                                  suffixIcon: InkWell(
                                    onTap: _toggleObscured,
                                    child: Icon(
                                      _obscured
                                          ? Icons.visibility_rounded
                                          : Icons
                                          .visibility_off_rounded,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    borderSide:
                                    errorpass=='n'?
                                    const BorderSide(
                                        color: Colors.green)
                                        : const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    borderSide:
                                    errorpass=='n'
                                        ? const BorderSide(
                                        color: Colors.green):
                                    const BorderSide(
                                        color: Colors.grey),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    borderSide:
                                    errorpass=='n'
                                        ? const BorderSide(
                                        color: Colors.green):
                                    const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    borderSide:
                                    errorpass=='n'?
                                    const BorderSide(
                                        color: Colors.green)
                                        : const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                ),
                              )
                          ),
                          SizedBox(height: 50,),
                          ElevatedButton(
                            onPressed: (){
                              FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text).then((value) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Home()),
                                );
                              }).onError((error, stackTrace) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${error.toString()}")));
                                print("Error ${error.toString()}");
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
                            child: Text("Login",style: TextStyle(fontSize: 17),),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("don't have account,",style: TextStyle(color: Colors.white),),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Register()),
                                    );
                                  },
                                  child: Text("Register",
                                      style: TextStyle(
                                          color: Colors.orangeAccent[400],
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)))
                            ],
                          ),
                        ],
                      ),
                    )
                  ]),
            )));
  }
}
