import 'package:flutter/material.dart';
import 'package:ninty_towshop/auth/signup.dart';
import 'package:ninty_towshop/home/home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();


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
      body: Column(
        children: [
          Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
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
                      obscureText: true,
                      controller: ctrlPassword,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter your password "
                      ),
                    ),
                  ),

                  ElevatedButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>Home()),
                    );
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
      ),
    );
  }
}
