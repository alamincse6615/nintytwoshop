import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var _key = GlobalKey<FormState>();

  final ctrlCategoryName = TextEditingController();
  final ctrlSubCategoryName = TextEditingController();
  final ctrlTitle = TextEditingController();
  final ctrlPrice = TextEditingController();
  final ctrlColor = TextEditingController();
  final ctrlQnt = TextEditingController();
  final ctrlSize = TextEditingController();
  final ctrlDescription = TextEditingController();
  final ctrlOfferPrice = TextEditingController();
  final ctrlOfferStartDate = TextEditingController();
  final ctrlOfferEndDate = TextEditingController();


  @override
  void dispose() {
    ctrlCategoryName.dispose();
    ctrlSubCategoryName.dispose();
    ctrlTitle.dispose();
    ctrlPrice.dispose();
    ctrlColor.dispose();
    ctrlQnt.dispose();
    ctrlSize.dispose();
    ctrlDescription.dispose();
    ctrlOfferPrice.dispose();
    ctrlOfferStartDate.dispose();
    ctrlOfferEndDate.dispose();
  }

  late DatabaseReference _databaseReference;

  @override
  void initState() {
    _databaseReference = FirebaseDatabase.instance.reference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: FutureBuilder(
        builder: (context,info){
          future: firebaseInit();
          return SingleChildScrollView(
            child: Column(
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
                            controller: ctrlSubCategoryName,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Sub Category Name"
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
                            controller: ctrlTitle,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Title"
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
                            controller: ctrlPrice,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Price"
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
                            controller: ctrlColor,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Color"
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
                            controller: ctrlQnt,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Quantity"
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
                            controller: ctrlSize,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Size"
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
                            controller: ctrlDescription,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Description"
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
                            controller: ctrlOfferPrice,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Offer Price"
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
                            controller: ctrlOfferStartDate,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Offer Start Date"
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
                            controller: ctrlOfferEndDate,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Offer End Date"
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: (){
                                _saveData(
                                  ctrlCategoryName.text,
                                  ctrlSubCategoryName.text,
                                  ctrlTitle.text,
                                  ctrlPrice.text,
                                  ctrlColor.text,
                                  ctrlQnt.text,
                                  ctrlSize.text,
                                  ctrlDescription.text,
                                  ctrlOfferPrice.text,
                                  ctrlOfferStartDate.text,
                                  ctrlOfferEndDate.text
                                );
                              },
                              child: Text("Add")
                          ),
                        )
                      ],
                    )
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _saveData(String catName,String subCatName,String title,String price,String color,String qnt,String size,String des,String ofPrice,String ofStartDate,String ofEndDate){
    FirebaseAuth auth = FirebaseAuth.instance;
    var isValid = _key.currentState!.validate();
    if(isValid){
      var _id = _databaseReference.child("Products").push().key;
      Map<dynamic,dynamic> info = {
        "id":_id,
        "uid":auth.currentUser!.uid,
        "cat_id":catName,
        "sub_cat_id":subCatName,
        "title":title,
        "price":price,
        "color":color,
        "quantity":qnt,
        "size":size,
        "description":des,
        "offerPrice":ofPrice,
        "offerStartDate":ofStartDate,
        "offerEndDate":ofEndDate,
        "image":"",
        "time":""
      };
      _databaseReference.child("Products").child(_id.toString()).set(info);
    }
  }

  Future<FirebaseApp> firebaseInit()async{
    FirebaseApp firebaseApp =await Firebase.initializeApp();
    return firebaseApp;
  }

}
