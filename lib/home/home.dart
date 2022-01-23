import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ninty_towshop/profile/profile.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late DatabaseReference _databaseReference;


  @override
  void initState() {
    _databaseReference = FirebaseDatabase.instance.reference();
  }

  Map<dynamic,dynamic> info = {
    "name":"yasin",
    "phn":"yasin3452115",
    "email":"yasin@gmail.com",
    "address":"shibchar,madaripur",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(auth.currentUser!.uid.toString()),

              RaisedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
                },
                color: Colors.green,
                child: Text("add info"),
              ),

              Container(
                height: 48,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.85,
                      height: 45,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Search",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60.0),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: (){

                                },
                                child: Icon(Icons.search),
                              )
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.15,
                      height: 40,
                      margin: EdgeInsets.all(0.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(
                          "images/people.png",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                    items: [
                      Card(
                        elevation: 2,
                        child: Image.network("https://static-01.daraz.com.bd/p/mdc/3318e704be7246fd1767429a1976c733.jpg_340x340q80.jpg_.webp",
                          width: MediaQuery.of(context).size.width,

                        ),
                      ),
                      Card(
                        elevation: 2,
                        child: Image.network("https://cpmr-islands.org/wp-content/uploads/sites/4/2019/07/test.png",
                          width: MediaQuery.of(context).size.width,

                        ),
                      ),
                    ],
                    options: CarouselOptions(
                      height: 170,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayAnimationDuration: Duration(seconds: 1),
                      autoPlayCurve: Curves.easeInOutBack,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    )
                ),
              ),
              Container(
                height: 130,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context,position){
                      return Card(
                        child: Column(
                          children: [
                            Image.network(
                              "https://cpmr-islands.org/wp-content/uploads/sites/4/2019/07/test.png",
                              height: 100,
                            ),
                            Text(" Name ")
                          ],
                        ),
                      );
                    }
                ),
              ),
              Container(
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (4/6),
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context,position){
                      return Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(
                                  "https://static-01.daraz.com.bd/p/mdc/3318e704be7246fd1767429a1976c733.jpg_340x340q80.jpg_.webp",
                                  height: 150,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 1.0,bottom: 3.0),
                                child: Text(
                                  " product title product title title",
                                  style: TextStyle(
                                    fontSize: 21,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "৳ 500",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6.0),
                                    child: Text(
                                      "৳ 410",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Text(" rating price "),

                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),


            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(children: [
          ListTile(
            title: Text("add category"),
            trailing: Icon(Icons.arrow_forward_ios),

          )
        ],),


      ),
    );
  }
}
