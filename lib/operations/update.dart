// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http_methods_poc/dbHelper/mongodb.dart';
import 'package:http_methods_poc/model/MongoDBModel.dart';
import 'package:http_methods_poc/operations/insert.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: 
       FutureBuilder(
        future: MongoDatabase.getData()
       , builder: (context,AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else{
          if(snapshot.hasData){
            return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return dispalyCard(//another function

                              MongoDbModel.fromJson(snapshot.data[index]));
                        });
          }else{
            return Center(
              child: Text("No data"),
            );
          }
        }

       })
      ),
    );
  }

 Widget dispalyCard(MongoDbModel data){
return Card(
  
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
      children: [
          Text("${data.id}"),
              SizedBox(height: 10),
      
        Text("${data.firstName}"),
        SizedBox(height: 10),
      
         Text("${data.lastName}"),
          SizedBox(height: 10),
      
          Text("${data.address}"),
           SizedBox(height: 10),
  
      ],
      ),
      IconButton(onPressed: (){
          Navigator.push(context,
           MaterialPageRoute(
            builder: (BuildContext context){
              return MongoDbInsert();
            },
            settings:RouteSettings(arguments: data))).then((value) {
              setState(() {
                
              });
            });
      }, 
      icon: Icon(Icons.edit)),
    ],
  ),
);
 }
}