import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class addSubCategory extends StatefulWidget {
  const addSubCategory({Key? key}) : super(key: key);

  @override
  _addSubCategoryState createState() => _addSubCategoryState();
}

class _addSubCategoryState extends State<addSubCategory> {

  var _key = GlobalKey<FormState>();
  final ctrlCategoryName = TextEditingController();
  final ctrlSubCategoryNameEn = TextEditingController();
  final ctrlSubCategoryNameBn = TextEditingController();

  late DatabaseReference _databaseReference;

  @override
  void initState() {
    _databaseReference = FirebaseDatabase.instance.reference();
  }


  @override
  void dispose() {
    ctrlSubCategoryNameEn.dispose();
    ctrlSubCategoryNameBn.dispose();
    ctrlCategoryName.dispose();
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
                          controller: ctrlCategoryName,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Category Name"
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
                          controller: ctrlSubCategoryNameEn,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Sub Category Name En"
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
                          controller: ctrlSubCategoryNameBn,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Sub Category Name Bn"
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: (){
                              _saveSubCategory(ctrlSubCategoryNameEn.text,ctrlSubCategoryNameBn.text,ctrlCategoryName.text);
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

  _saveSubCategory(String sctNameEn, String sctNameBn, String categoryName){
    FirebaseAuth auth = FirebaseAuth.instance;
    var isValid = _key.currentState!.validate();
    if(isValid){
      var _id = _databaseReference.child("SubCategoey").push().key;
      Map<dynamic,dynamic> info = {
        "id":_id,
        "uid":auth.currentUser!.uid,
        "cat_id":categoryName,
        "subCategoryNameEn":sctNameEn,
        "subCategoryNameBn":sctNameBn,
        "image":"",
        "time":"",
      };
      _databaseReference.child("subCategory").child(_id.toString()).set(info);
    }
  }

  Future<FirebaseApp> firebaseInit()async{
    FirebaseApp firebaseApp =await Firebase.initializeApp();
    return firebaseApp;
  }


}
