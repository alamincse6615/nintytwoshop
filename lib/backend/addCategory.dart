import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ninty_towshop/backend/category.dart';

class addCategory extends StatefulWidget {
  const addCategory({Key? key}) : super(key: key);

  @override
  _addCategoryState createState() => _addCategoryState();
}

class _addCategoryState extends State<addCategory> {

  var _key = GlobalKey<FormState>();
  final ctrlCategoryNameEn = TextEditingController();
  final ctrlCategoryNameBn = TextEditingController();

  late DatabaseReference _databaseReference;

  @override
  void initState() {
    _databaseReference = FirebaseDatabase.instance.reference();
  }

  @override
  void dispose() {
    ctrlCategoryNameEn.dispose();
    ctrlCategoryNameBn.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: FutureBuilder(
        builder: (context,info){
          future: firebaseInit();
          return Column(
            children: [
              Form(
                  key: _key,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator:(val){
                            if(val == ""){
                              return "Name Can't be empty";
                            }
                          },
                          controller: ctrlCategoryNameEn,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Category Name En"
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator:(val){
                            if(val == ""){
                              return "Name Can't be empty";
                            }
                          },
                          controller: ctrlCategoryNameBn,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Category Name Bn"
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: (){
                              _saveCategory(ctrlCategoryNameEn.text,ctrlCategoryNameBn.text);
                            },
                            child: Text("Add")
                        ),
                      )
                    ],
                  )
              )
            ],
          );
        },
      ),
    );
  }

  _saveCategory(String ctNameEn, String ctNameBn){
    FirebaseAuth auth = FirebaseAuth.instance;
    var isValid = _key.currentState!.validate();
    if(isValid){
      Map<dynamic,dynamic> info = {
        "uid": auth.currentUser!.uid,
        "categoryNameEn":ctNameEn,
        "CategoryNameBn":ctNameBn
      };
      _databaseReference.child("Category").push().set(info);
      Navigator.push(
          context,
        MaterialPageRoute(
            builder: (context)=>Category()
        )
      );
    }else{
      return;
    }
  }

  Future<FirebaseApp> firebaseInit()async{
    FirebaseApp firebaseApp =await Firebase.initializeApp();
    return firebaseApp;
  }


}
