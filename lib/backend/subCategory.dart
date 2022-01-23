import 'package:flutter/material.dart';
import 'package:ninty_towshop/backend/addSubCategory.dart';

class subCategory extends StatefulWidget {
  const subCategory({Key? key}) : super(key: key);

  @override
  _subCategoryState createState() => _subCategoryState();
}

class _subCategoryState extends State<subCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Category"),
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
                        builder: (context)=>addSubCategory(),
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
