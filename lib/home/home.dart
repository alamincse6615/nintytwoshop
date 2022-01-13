import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Container(
            color: Colors.red,
            height: 100,
            child: Row(
              children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: GestureDetector(
                        onTap: (){

                        },
                        child: Icon(Icons.search),
                      )
                  ),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(
                      "images/people.jpg"
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context,position){
                  return Card(
                    child: Column(
                      children: [
                        Image.network("https://cpmr-islands.org/wp-content/uploads/sites/4/2019/07/test.png"),
                        Text(" Name ")
                      ],
                    ),
                  );
                }
            ),
          ),
          Container(
            height: 350,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (context,position){
                  return Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Image.network("https://cpmr-islands.org/wp-content/uploads/sites/4/2019/07/test.png"),
                        Text(" product title "),
                        Text(" old price "),
                        Text(" discount price "),
                        Text(" rating price "),

                      ],
                    ),
                  );
                }
            ),
          ),


        ],
      ),
    );
  }
}
