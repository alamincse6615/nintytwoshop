import 'package:flutter/material.dart';
import 'package:ninty_towshop/backend/addCategory.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ninty_towshop/backend/categoryEdit.dart';

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
    final category = _databaseReference.child("Category");
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*.1,
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
            height: MediaQuery.of(context).size.height*.785,
            child: FirebaseAnimatedList(

                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index){
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context)=>categoryEdit(
                                              snapshot.child("id").value
                                            )
                                        )
                                    );
                                  },
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
                            height: 1,
                            color: Colors.black26,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.network(
                                  snapshot.child("image").value.toString(),
                                  height: 200,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                snapshot.child("categoryNameEn").value.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.child("CategoryNameBn").value.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              query: category,
            ),
          )
        ],
      ),
    );
  }
}
