import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:ninty_towshop/backend/addSubCategory.dart';
import 'package:firebase_database/firebase_database.dart';

class subCategory extends StatefulWidget {
  const subCategory({Key? key}) : super(key: key);

  @override
  _subCategoryState createState() => _subCategoryState();
}

class _subCategoryState extends State<subCategory> {

  late DatabaseReference _databaseReference;
  @override
  void initState() {
    _databaseReference = FirebaseDatabase.instance.reference();
  }
  
  @override
  Widget build(BuildContext context) {
    final subProduct = _databaseReference.child("subCategory");
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Category"),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            child: Center(
              child: ElevatedButton(
                child: Text("Add Category"),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=>addSubCategory(),
                      )
                  );
                },
              ),
            ),
          ),
          Container(
            height: 500,
            child: FirebaseAnimatedList(
                query: subProduct,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: Column(
                        children: [
                          Text(snapshot.child("cat_id").value.toString()),
                          Text(snapshot.child("subCategoryNameBn").value.toString())
                        ],
                      ),
                    ),
                  );
                },
            )
          )
        ],
      ),
    );
  }
}
