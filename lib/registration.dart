import 'dart:convert';
import 'dart:html';
import 'dart:io';
import 'package:http/http.dart'as http;

import 'package:flutter/material.dart';
import 'package:qr_app/login.dart';

class registration extends StatefulWidget {
  const registration({Key? key}) : super(key: key);

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  final TextEditingController name = TextEditingController();
  final TextEditingController rollno= TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool loading =false;

  Future<void> registration() async {
    Uri uri=Uri.parse('https://scnner-web.onrender.com/api/register');
    var response = await http.post(uri,
    headers: <String,String> {
          'Content-Type': 'application/json;charset=UTF-8',
        },
      body: jsonEncode({
      'name':name.text,
      'rollno':rollno.text,
      'username':username.text,
      'password':password.text,
      }));
    print(response.statusCode);
    print(response.body);
    var data =jsonDecode(response.body);
    print(data["message"]);

    if(response.statusCode ==200){
      Navigator.push(context,MaterialPageRoute(builder: (Context)=> Login()));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data["message"]),
      ));
    }
    print(name.text);
    print(rollno.text);
    print(username.text);
    print(password.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
        appBar: AppBar(
      title: Text('REGISTRATION'),),
      body:Center(
        child: 
          Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(controller:name,decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full name',
                    hintText: 'Enter Fullname'
                ),  ),
              ),
              SizedBox(
                height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(controller:rollno,decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Roll no.',
                    hintText: 'Enter Roll no.'
                ),  ),
              ),
              SizedBox(
                height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(controller:username,decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    hintText: 'Enter Username'
                ),  ),
              ),
              SizedBox(
                height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(controller:password,decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Password'
                ),  ),
              ),
              SizedBox(
                height: 20,),
              TextButton(onPressed: registration, child: Text('Register',style: TextStyle(color: Colors.green),))
          
            ],),
      )
    );
  }
}
