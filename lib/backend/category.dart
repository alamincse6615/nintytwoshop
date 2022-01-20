import 'package:flutter/material.dart';
import 'package:ninty_towshop/backend/addCategory.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
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
          )
        ],
      ),
    );
  }
}
