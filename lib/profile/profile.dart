import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? imageFile;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: imageFile == null
                  ? Container(
                  child: Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://www.pngitem.com/pimgs/m/22-223968_default-profile-picture-circle-hd-png-download.png"),
                          radius: 80,
                        ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Choose Image",
                                              style: TextStyle(fontSize: 25),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      getImageFromGallery();
                                                    },
                                                    icon: Icon(
                                                      Icons.image,
                                                      color: Colors.blue,
                                                    )),
                                                IconButton(
                                                    onPressed: () {
                                                      getImageFromCamera();
                                                    },
                                                    icon: Icon(
                                                      Icons.camera,
                                                      color: Colors.blue,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(Icons.camera_alt),
                            ))
                      ],
                    ),
                  ))
                  : Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: FileImage(imageFile!),
                          radius: 80,
                        ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Choose Image",
                                              style: TextStyle(fontSize: 25),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      getImageFromGallery();
                                                    },
                                                    icon: Icon(
                                                      Icons.image,
                                                      color: Colors.blue,
                                                    )),
                                                IconButton(
                                                    onPressed: () {
                                                      getImageFromCamera();
                                                    },
                                                    icon: Icon(
                                                      Icons.camera,
                                                      color: Colors.blue,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              icon: Icon(Icons.camera_alt),
                            ))
                      ],
                    ),
                  ),
                  RaisedButton(
                      child: Text("upload image"),
                      onPressed: (){
                        uploadImageToFirebase( imageFile!);
                      })
                ],
              ),
            )

            /*
             Container(
              child: imageFile==null?Container(
                child: InkWell(
                    child: Image.network("https://cdn5.vectorstock.com/i/1000x1000/71/64/gallery-icon-vector-26537164.jpg"),
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
            */

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

  getImageFromGallery() async {
    PickedFile? picked =
    await ImagePicker().getImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }
  getImageFromCamera() async {
    PickedFile? picked = await ImagePicker().getImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  uploadImageToFirebase(File imageFile)async{


    fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("userImage").child(FirebaseAuth.instance.currentUser!.uid);
    fStorage.UploadTask uploadTask = reference.putFile(imageFile);
    fStorage.TaskSnapshot taskSnapshot =await uploadTask.whenComplete(() {});
    await taskSnapshot.ref.getDownloadURL().then((url) {
      imageUrl = url;
      print(imageUrl);
    });

  }
}
