import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ninty_towshop/auth/signup.dart';
import 'package:ninty_towshop/backend/adminHome.dart';
import 'package:ninty_towshop/home/home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var _key = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool passOff = true;
  Icon passIcon = Icon(Icons.visibility_off) ;


  @override
  void dispose() {
    ctrlName.dispose();
    ctrlEmail.dispose();
    ctrlPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text("Sign In to continue"),
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
                          validator: (val){
                            if(val == ""){
                              return "can't be emty";
                            }
                            else if(!(val!.length < 50) && !(val.length >10 )){
                              return "Invalid data";
                            }
                          },
                          controller: ctrlEmail,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter your email "
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (val){
                            if(val == ""){
                              return "con't be emty";
                            }
                            else if(!(val!.length < 50) && !(val.length > 10)){
                              return "Invalid password";
                            }
                          },
                          obscureText: passOff,
                          controller: ctrlPassword,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if(passOff){
                                      passOff = false;
                                      passIcon = Icon(Icons.visibility);
                                    }else if(!passOff){
                                      passOff = true;
                                      passIcon = Icon(Icons.visibility_off);
                                    }
                                  }
                                  );
                                },
                                child: passIcon,
                              ),
                              border: OutlineInputBorder(),
                              hintText: "Enter your password "
                          ),
                        ),
                      ),

                      ElevatedButton(
                          onPressed: (){
                            signinFunc(ctrlName.text, ctrlEmail.text, ctrlPassword.text);
                          },
                          child: Text("Sign In")),
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Create an Account ? "),
                            InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context)=>SignUp()),
                                  );
                                },
                                child: Text("Sign Up ",style: TextStyle(color: Colors.blue),)),
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
  signinFunc(String name, String email, String password)async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var isValid = _key.currentState!.validate();
    if (isValid) {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      if(userCredential.user != null){

        if(email == 'md.shohelshikder2000@gmail.com' && auth.currentUser!.email == 'md.shohelshikder2000@gmail.com'){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => adminHome()),
          );
        }else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        }



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
