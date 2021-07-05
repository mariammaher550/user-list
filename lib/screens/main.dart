import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_list2/screens/edit_form_screen.dart';
import 'package:user_list2/screens/form_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_list2/services/data.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users',
      home: MyHomePage(title: 'Users List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              right: 5 ,
              bottom: 20,
              child: FloatingActionButton(
            child: const Icon(Icons.add),
              onPressed: (){
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => formScreen())
                );
              }
          )),
          Positioned(
              left: 30,
              bottom: 20,
              child: FloatingActionButton(
              child: const Icon(Icons.delete),
              onPressed: (){
                deleteData();
              }
          )),
        ],

      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children : snapshot.data.docs.map((doc){
              return Center(
                child: Container(
                 // width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height,
                  child: new GestureDetector(
                    onTap: () {
                      setValues(doc['Username'], doc['Name'], doc['Surname'], doc['Phone Number']);
                //redirect to page to edit , delete , cancel data AlertDialog
                     // print("Runtime type is: " + doc.runtimeType.toString());
                     displayData(context, doc);
              },
                child: new Text(doc['Username']),
              ),
                )
              );
            }).toList()

          );
        },


        
      )

    );
  }
}

