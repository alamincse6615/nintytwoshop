
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ninty_towshop/backend/category.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

class addCategory extends StatefulWidget {
  const addCategory({Key? key}) : super(key: key);

  @override
  _addCategoryState createState() => _addCategoryState();
}

class _addCategoryState extends State<addCategory> {
  var _key = GlobalKey<FormState>();
  final ctrlCategoryNameEn = TextEditingController();
  final ctrlCategoryNameBn = TextEditingController();
  File? ImageFile;
  String? imageUrl;
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
                      Container(
                        height: 110,
                        child: ImageFile==null? Image.network("https://cdn5.vectorstock.com/i/1000x1000/71/64/gallery-icon-vector-26537164.jpg"): Image.file(ImageFile!),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          showModalBottomSheet(
                              context: context,
                              builder:(context){
                                return Container(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Choose Image",
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                getImageFromGallery();
                                              },
                                              icon: Icon(
                                                Icons.image,
                                                color: Colors.blue,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                getImageFromCamera();
                                              },
                                              icon: Icon(
                                                Icons.camera,
                                                color: Colors.blue,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }
                          );
                        },
                        child: Text("Add Image"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: (){
                              _saveCategory(ctrlCategoryNameEn.text,ctrlCategoryNameBn.text,ImageFile!);
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

  _saveCategory(String ctNameEn, String ctNameBn, File imageFile)async{
    FirebaseAuth auth = FirebaseAuth.instance;
    var isValid = _key.currentState!.validate();
    if(isValid){
      var _id = _databaseReference.child("Category").push().key;

      fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("Category").child(_id.toString());
      fStorage.UploadTask uploadTask = reference.putFile(imageFile);
      fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      await taskSnapshot.ref.getDownloadURL().then((url){
        imageUrl = url;
      });

      Map<dynamic,dynamic> info = {
        "id":_id,
        "uid": auth.currentUser!.uid,
        "categoryNameEn":ctNameEn,
        "CategoryNameBn":ctNameBn,
        "image":imageUrl,
        "time":""
      };
      _databaseReference.child("Category").child(_id.toString()).set(info);
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

  getImageFromGallery()async{
    PickedFile? picked = await ImagePicker().getImage(source: ImageSource.gallery);
    if(picked !=null){
      setState(() {
        ImageFile = File(picked.path);
      });
    }
  }

  getImageFromCamera()async{
    PickedFile? picked = await ImagePicker().getImage(source: ImageSource.camera);
    if(picked !=null){
      setState(() {
        ImageFile = File(picked.path);
      });
    }
  }

}
