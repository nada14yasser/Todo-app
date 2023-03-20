import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formkey = GlobalKey< FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final nameFocusNode = FocusNode();
  bool _obscured = true;
  bool _obscured2 = true;
  //validation and save button
  bool isButtonActiveName = false;
  bool isButtonActivePass = false;
  bool isButtonActiveConfirmPass = false;
  bool isButtonActiveEmail = false;
  var errorname = '';
  var errorpass = '';
  var erroremail = '';
  var errorconpass = '';
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (passwordFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      passwordFocusNode.canRequestFocus = false; // Prevents focus if tap on eye
    });
  }
  void _toggleObscured2() {
    setState(() {
      _obscured2 = !_obscured2;
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
                      height: 50,
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Login()),
                              );
                            },
                            icon: Icon(Icons.arrow_back,color: Colors.white,size: 40,))
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                    const SizedBox(
                      height: 80,
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
                                controller: nameController,
                                cursorColor: Colors.grey,
                                onChanged: (val)async {
                                  isButtonActiveName = formkey
                                      .currentState!
                                      .validate();
                                  isButtonActiveName
                                      ? setState(() {})
                                      : null;
                                },
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r"^[آ-یA-z]{2,}(|[ ]?)$" )
                                          .hasMatch(value)) {
                                    // return "name is required";
                                  }
                                  else {
                                    setState(() {
                                      errorname = 'n';
                                    });
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  errorStyle:
                                  TextStyle(
                                    color: errorname==''?Colors.red:Colors.green,),
                                  contentPadding:
                                  const EdgeInsets.all(20),
                                  hintText: "name",
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15),
                                  suffixIcon: InkWell(
                                      onTap: () {
                                        nameController.clear();
                                        setState(() {
                                          nameController.text = '';
                                        });
                                      },
                                      child: Icon(
                                        errorname==''
                                            ? Icons.close
                                            : Icons.done,
                                        size: 20,
                                        color:  errorname==''
                                            ? Colors.redAccent
                                            : Colors.green.shade400,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    borderSide:
                                    errorname=='n'?
                                    const BorderSide(
                                        color: Colors.green)
                                        : const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    borderSide:
                                    errorname=='n'
                                        ? const BorderSide(
                                        color: Colors.green):
                                    const BorderSide(
                                        color: Colors.grey),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    borderSide:
                                    errorname=='n'
                                        ? const BorderSide(
                                        color: Colors.green):
                                    const BorderSide(
                                        color: Colors.redAccent),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                    borderSide:
                                    errorname=='n'?
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
                                obscureText: _obscured,
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
                          SizedBox(height: 20,),
                          Container(
                              width:300 ,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: const BorderRadius.all(Radius.circular(25)),
                              ),
                              child: TextFormField(
                                  controller: confirmPassController,
                                  keyboardType: TextInputType
                                      .visiblePassword,
                                  obscureText: _obscured2,
                                  cursorColor: Colors.grey,
                                  onChanged: (val) {
                                    isButtonActiveConfirmPass =
                                        formkey
                                            .currentState!
                                            .validate();
                                    isButtonActiveConfirmPass
                                        ? setState(() {})
                                        : null;
                                  },
                                  validator: (value) {
                                    if (value != passwordController.text){
                                      // return "not match";
                                    }
                                    else {
                                      setState(() {
                                        errorconpass = 'n';
                                      });
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(
                                        20),
                                    hintText: "confirm password",
                                    hintStyle: TextStyle(color: Colors.white,
                                        fontSize: 15),
                                    floatingLabelBehavior: FloatingLabelBehavior
                                        .never,
                                    isDense: true,
                                    suffixIcon: InkWell(
                                      onTap: _toggleObscured2,
                                      child: Icon(
                                        _obscured2
                                            ? Icons.visibility_rounded
                                            : Icons.visibility_off_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25)),
                                      borderSide: errorconpass=='n'?
                                      const BorderSide(
                                          color: Colors.green)
                                          : const BorderSide(
                                          color: Colors.redAccent),
                                    ),
                                    enabledBorder:
                                     OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25)),
                                        borderSide: errorconpass=='n'?
                                        const BorderSide(
                                            color: Colors.green)
                                            : const BorderSide(
                                            color: Colors.grey),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25)),
                                      borderSide: errorconpass=='n'?
                                      const BorderSide(
                                          color: Colors.green)
                                          : const BorderSide(
                                          color: Colors.redAccent),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25)),
                                      borderSide: errorconpass==''?
                                      const BorderSide(
                                          color: Colors.green)
                                          : const BorderSide(
                                          color: Colors.redAccent),
                                    ),
                                  )),
                          ),
                          SizedBox(height: 50,),
                          ElevatedButton(
                            onPressed: (){
                              FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text).then((value){
                                    print("Account Created");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Home()),
                                );
                              }).onError((error, stackTrace) {
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
                            child: Text("Register",style: TextStyle(fontSize: 17),),
                          ),
                        ],
                      ),
                    )
                  ]),
            )));
  }
}
