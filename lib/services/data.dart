import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_list2/screens/edit_form_screen.dart';

Future<void> addData(String username, String surname ,String name, String phoneNumber) async {
  DocumentReference ref = FirebaseFirestore.instance.collection('Users').doc(username);
  ref.set({'Username' : username, 'Surname' : surname, 'Name' : name, 'Phone Number': phoneNumber});

  return;
}
void displayData(BuildContext context, QueryDocumentSnapshot doc ){
   Map<String, dynamic> map = doc.data();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("User data"),
              content: new Text("Username:" + map['Username'] + "\n"
                "Name:" + map['Name'] + "\n"
                "Surname:" + map['Surname'] + "\n"
                "Phone Number:" + map['Phone Number'] + "\n"
              ),
              actions: <Widget>[
                Positioned(
                    left: 30,
                    bottom: 20,
                    child: FloatingActionButton(
                      child: Icon(
                          Icons.edit
                      ),
                      onPressed: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => editFormScreen())
                        );

                      },
                    )
                ),
              ],
            );
          },
        );

}

void deleteData() async{
  await FirebaseFirestore.instance.collection('Users').get().then((snapshot) {
    for (DocumentSnapshot ds in snapshot.docs){
      ds.reference.delete();
  }});
}