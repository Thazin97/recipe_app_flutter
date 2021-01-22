import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:receipes/screens/drawer_page.dart';
import 'package:receipes/screens/registration_page.dart';
import 'package:receipes/themes/colors.dart';
import 'package:receipes/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final formkey = GlobalKey<FormState> ();
  TextEditingController usernameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  bool showProgress = false;
  final _auth = FirebaseAuth.instance;
  String username ,email, password;
  Color _iconColor = AppColor.midnightblue;
  Color _textColor = Colors.black54;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[200],
        body:Stack(
            children:[
              Opacity(
                opacity: 0.3,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: FittedBox(child: Image.asset('images/pastel.jpg'),
                      fit: BoxFit.cover),

                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0,vertical: 88.0),
                child: Column(
                  children: [
                    Text('Welcome Back',style: TextStyle(color: _iconColor,fontSize:24.0,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5.0,),
                    Text('Sign In to continue...',style: TextStyle(
                        color: _textColor,fontSize: 16.0
                    ),)
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height-10,
                  child:Center(
                    child: ModalProgressHUD(
                      inAsyncCall: showProgress,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Form(
                            key: formkey,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:20.0),
                                    child:  TextFormField(
                                      onChanged: (value){
                                        email = value;
                                      },
                                      validator: (val){
                                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ? null : 'Please enter a valid email';
                                      },
                                      controller: emailTextEditingController,
                                      decoration: textFieldInputDecoration('Email address', Icons.email),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: TextFormField(
                                      obscureText: true,
                                      onChanged: (value){
                                        password = value;
                                      },
                                      validator: (val){
                                        return val.length >6 ? null : 'Password must be longer than 6 characters';
                                      },
                                      controller: passwordTextEditingController,
                                      decoration: textFieldInputDecoration('Password', Icons.lock),
                                    ),

                                  ),
                                ]
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32.0),
                                color: _iconColor
                            ),
                            child: MaterialButton(
                              onPressed: () async {
                                if (formkey.currentState.validate()) {
                                  setState(() {
                                    showProgress = true;
                                  });
                                  try {
                                    final newUser = await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                    print(newUser.toString());
                                    if (newUser != null) {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setString('email', email);
                                      Fluttertoast.showToast(
                                          msg: "Login Successful",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.blueAccent,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HeaderProvider()));
                                      setState(() {
                                        showProgress = false;
                                      });
                                    }
                                  }
                                  catch (e) {
                                    print('error' + e.toString());
                                  }
                                  return null;
                                }
                              },
                              minWidth: 200.0,
                              height: 45.0,
                              child: Text(
                                "Login",
                                style:
                                TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0,color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    color:_textColor,fontSize: 15.0),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=> RegistrationPage()));
                                  },
                                  child: Text('Sign Up',style: TextStyle(decoration: TextDecoration.underline,fontSize: 19.0,color: _iconColor,fontWeight: FontWeight.w900),))
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              )
            ])
    );
  }
}

