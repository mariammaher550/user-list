import 'package:flutter/material.dart';
import 'package:user_list2/services/data.dart';
class formScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _formScreenState();

}
class _formScreenState extends State<formScreen>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _username = '';
  String _name = '';
  String _surname = '';
  String _phoneNumber = '';
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Form Page')
      ),
       floatingActionButton: Stack(
         fit: StackFit.expand,
         children: [
           Positioned(
               left: 30,
               bottom: 20,
               child: FloatingActionButton(
                 child: Icon(
                   Icons.cancel
                 ),
                 onPressed: (){
                   Navigator.pop(context);
                 },
               )
           ),
           Positioned(
               right: 5 ,
               bottom: 20,
               child: FloatingActionButton(
                   child: Icon(
                       Icons.done
                   ),
                 // onPressed: () {
                 //   addData(username, surname, name, phoneNumber);
                 //   Navigator.pop(context);
                 // }
                    onPressed: ()  {
                      if (_formKey.currentState.validate()) {
                        addData(_username, _surname, _name, _phoneNumber);
                        Navigator.pop(context);
                      }
                      else{
                        SizedBox(height: 12.0);
                      Text(
                      "Something went wrong",
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                      );
                      }
                    }
                   )
                   )
                   ]),
                   body: Container(
                   child: Form(
                   key: _formKey,
                   child: Column(
                   children: <Widget>[
                   SizedBox(height: 20.0),
                   TextFormField(
                   decoration: InputDecoration(
                   helperText: 'Username',
                   //  hintText: "Hello"
                   ),
                   validator: (val) {
                   if (val.isEmpty) return 'Empty Field, please enter your username';
                   else return null;
                   },
                   onChanged: (val){
                   setState(() => _username = val);
                   }
                 ),
             SizedBox(height: 20.0),
             TextFormField(
               decoration: InputDecoration(
                   helperText: 'Surname'
               ),
               validator: (val) => ( val.isEmpty)  ? 'Empty Field, please enter your surname'  : null, // We can add validation conditions we want here
               onChanged: (val){
                 setState(() => _surname = val);
               },
             ),
               SizedBox(height: 20.0),
               TextFormField(
                 decoration: InputDecoration(
                     helperText: 'Name'
                 ),
                 validator: (val) => (val.isEmpty)  ? 'Empty Field, Please enter your name'  : null, // We can add validation conditions we want here
                 onChanged: (val){
                   setState(() => _name = val);
                 },
               ),
               TextFormField(
                 decoration: InputDecoration(
                     helperText: 'Phone Number'
                 ),
                 validator: (val) => (val.isEmpty || val.length != 12)  ? 'Please your phone number in correct format'  : null, // We can add validation conditions we want here
                 onChanged: (val){
                   setState(() => _phoneNumber = val);
                   //  _auth.setPw= password;
                 },
               ),
           ],

           )
         ),
       ),
     );
  }
}

