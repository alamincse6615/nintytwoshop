import 'package:flutter/material.dart';
import 'package:ninty_towshop/backend/addCategory.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  late DatabaseReference _databaseReference;
  @override
  void initState() {
    _databaseReference = FirebaseDatabase.instance.reference();
  }


  @override
  Widget build(BuildContext context) {
    final category = _databaseReference.child("subCategory");
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: Column(
        children: [
          Container(
            child: Center(
              child: ElevatedButton(
                child: Text("Add Category"),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>addCategory(),
                      )
                  );
                },
              ),
            ),
          ),
          Container(
            child: FirebaseAnimatedList(
                 query: category,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
                  return Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: (){},
                                icon: Icon(
                                  Icons.edit
                                ),
                            ),
                            IconButton(
                                onPressed: (){},
                                icon: Icon(
                                  Icons.delete
                                ),
                            ),
                          ],
                        ),
                        Container(
                          height: 2,
                          color: Colors.black26,
                        )
                      ],
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}
