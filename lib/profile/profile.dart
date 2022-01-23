import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            Container(
              child: imageFile==null?Container(
                child: InkWell(child: Image.network("https://cdn5.vectorstock.com/i/1000x1000/71/64/gallery-icon-vector-26537164.jpg"),
                  onTap: ()async {
                    PickedFile? picked = await ImagePicker().getImage(
                        source: ImageSource.gallery);
                    if (picked != null) {
                      setState(() {
                        imageFile = File(picked.path);
                      });
                    }
                  })
              ):InkWell(child: Image.file(imageFile!),
                onTap: ()async{
                  PickedFile? picked = await ImagePicker().getImage(source: ImageSource.gallery);
                  if(picked != null){
                    setState(() {
                      imageFile = File(picked.path);
                    });
                  }
                },

              )
            ),

            /*RaisedButton(onPressed: ()async{
              PickedFile? picked = await ImagePicker().getImage(source: ImageSource.gallery);
              if(picked != null){
                setState(() {
                  imageFile = File(picked.path);
                });
              }
            },color: Colors.green,)*/
          ],
        ),
      ),
    );
  }
}
