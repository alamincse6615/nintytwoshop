
import 'package:flutter/material.dart';
import 'package:ninty_towshop/backend/category.dart';

class adminHome extends StatefulWidget {
  const adminHome({Key? key}) : super(key: key);

  @override
  _adminHomeState createState() => _adminHomeState();
}

class _adminHomeState extends State<adminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Admin")),

      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text("Category"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>Category(),
                      )
                  );
              },
            )
          ],
        ),
      ),
    );
  }
}
