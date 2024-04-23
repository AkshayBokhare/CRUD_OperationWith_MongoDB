// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:faker/faker.dart';
import 'package:faker/faker.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:http_methods_poc/dbHelper/mongodb.dart';
import 'package:http_methods_poc/model/MongoDBModel.dart';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
        
         FutureBuilder(
          future: MongoDatabase.getData(),
          builder: (context, AsyncSnapshot snapshot){

            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
                  if(snapshot.hasData){
                        var totaldata = snapshot.data.length;
                        print("Data Found" +totaldata.toString());
                       
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder:(context,index){
                          return dispalCard(   //another function

                          MongoDbModel.fromJson(snapshot.data[index]));

                          });
                  }else{
                    return Center(
                      child: Text("No Data Avilable"),
                    );
                  }
            }
        })
        
        ),
        
      );
  }

  Widget dispalCard(MongoDbModel data){
return Card(
  
  child: Column(
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
);
  }
}