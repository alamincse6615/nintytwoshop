import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ninty_towshop/auth/signin.dart';
import 'package:ninty_towshop/home/home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _key = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool passOff = true;
  Icon passIcon = Icon(Icons.visibility_off);

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlEmail.dispose();
    ctrlPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up to continue"),
      ),
      body: FutureBuilder(
        future: firebaseInit(),
        builder: (context,info){
          return Column(
            children: [
              Form(
                  key: _key,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (val) {
                            if (val == "") {
                              return "Name Can't be empty";
                            } else if (!(val!.length < 50) && !(val.length > 10)) {
                              return "Name is invalid";
                            }
                          },
                          controller: ctrlName,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter your name "),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (val) {
                            if (val == "") {
                              return "email Can't be empty";
                            }
                          },
                          controller: ctrlEmail,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter your email "),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (val) {
                            if (val == "") {
                              return "password Can't be empty";
                            } else if (val!.length < 6) {
                              return "password must be at lest 6 charecter";
                            }
                          },
                          obscureText: passOff,
                          controller: ctrlPassword,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (passOff) {
                                      passOff = false;
                                      passIcon = Icon(Icons.visibility);
                                    } else if (!passOff) {
                                      passOff = true;
                                      passIcon = Icon(Icons.visibility_off);
                                    }
                                  });
                                },
                                child: passIcon,
                              ),
                              border: OutlineInputBorder(),
                              hintText: "Enter your password "),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            signUupfun(
                                ctrlName.text, ctrlEmail.text, ctrlPassword.text);
                          },
                          child: Text("Sign Up")),
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an Account? "),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()),
                                  );
                                },
                                child: Text(
                                  "Login ",
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      )
                    ],
                  )
              ),
            ],
          );
        },
      )
    );
  }

  signUupfun(String name, String email, String password)async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var isValid = _key.currentState!.validate();
    if (isValid) {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      if(userCredential.user != null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );

      }

    } else {
      return;
    }
  }
  Future<FirebaseApp> firebaseInit()async{
    FirebaseApp firebaseApp =await Firebase.initializeApp();
    return firebaseApp;
  }
}
