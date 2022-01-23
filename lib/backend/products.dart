import 'package:flutter/material.dart';
import 'package:ninty_towshop/backend/addProduct.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: Column(
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
      ),
    );
  }
}
