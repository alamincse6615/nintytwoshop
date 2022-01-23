import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:ninty_towshop/backend/addProduct.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  late DatabaseReference _databaseReference;
  @override
  void initState() {
    _databaseReference = FirebaseDatabase.instance.reference();
  }

  @override
  Widget build(BuildContext context) {
    final productRef =_databaseReference.child("Products");

    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: FirebaseAnimatedList(
        itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index)
        { return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            child: Column(
              children: [
                  Text(snapshot.child("title").value.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                  Text(snapshot.child("description").value.toString(),style: TextStyle(fontWeight: FontWeight.normal,fontSize: 18),),
                  Text(snapshot.child("price").value.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  Text(snapshot.child("size").value.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  Text(snapshot.child("quantity").value.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
              ],
            ),
          ),
        );
        },
        query: productRef,
      ),
      /*body: Column(
        children: [
          Container(
            child: Center(
              child: ElevatedButton(
                child: Text("Add Product"),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=>AddProduct(),
                      )
                  );
                },
              ),
            ),
          )
        ],
      ),*/
    );
  }
}
