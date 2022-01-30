
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ninty_towshop/backend/category.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

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
  File? ImageFile;
  String? ImageUrl;

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
                      InkWell(
                        child:  Container(
                          height: 150,
                          width: 200,
                          child: ImageFile == null? Image.network("https://skillz4kidzmartialarts.com/wp-content/uploads/2017/04/default-image.jpg"):
                              Container(
                                child: Image.network(""),
                              )
                        ),
                        onTap: (){
                          showModalBottomSheet(
                              context: context,
                              builder: (context){
                                return Container(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Choice Image",
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.teal
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                              onPressed: (){
                                                getImageFromGallery();
                                              },
                                              icon: Icon(
                                                Icons.camera_alt_outlined,
                                                size: 45,
                                                color: Colors.teal,
                                              )
                                          ),
                                          IconButton(
                                              onPressed: (){},
                                              icon: Icon(
                                                Icons.camera,
                                                size: 45,
                                                color: Colors.teal,
                                              )
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }
                          );
                        } ,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: (){
                              _saveSubCategory(ctrlSubCategoryNameEn.text,ctrlSubCategoryNameBn.text,ctrlCategoryName.text,ImageFile!);
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

  _saveSubCategory(String sctNameEn, String sctNameBn, String categoryName, File ImageFile) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    var isValid = _key.currentState!.validate();
    if(isValid){
      var _id = _databaseReference.child("SubCategoey").push().key;

        fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("subCatagory").child(FirebaseAuth.instance.currentUser!.uid);
        fStorage.UploadTask uploadTask = reference.putFile(ImageFile);
        fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        await taskSnapshot.ref.getDownloadURL().then((url) {
          ImageUrl = url;
        }
        );

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


  getImageFromGallery() async {
    PickedFile? picked =
    await ImagePicker().getImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        ImageFile = File(picked.path);
      });
    }
  }



  Future<FirebaseApp> firebaseInit()async{
    FirebaseApp firebaseApp =await Firebase.initializeApp();
    return firebaseApp;
  }


}
