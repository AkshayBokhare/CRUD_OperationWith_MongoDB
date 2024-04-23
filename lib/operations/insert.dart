// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:http_methods_poc/dbHelper/mongodb.dart';
import 'package:http_methods_poc/model/MongoDBModel.dart';
import "package:mongo_dart/mongo_dart.dart" as M;

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({super.key});

  @override
  State<MongoDbInsert> createState() => _MongoDbInsert();
}

class _MongoDbInsert extends State<MongoDbInsert> {


var fnameController = TextEditingController();
var lnameController = TextEditingController();
var addressController = TextEditingController();

var _checkInsertUpdate = "Insert";


  @override
  Widget build(BuildContext context) {

    MongoDbModel data = ModalRoute.of(context)!.settings.arguments as MongoDbModel;
    if(data !=null){
      fnameController.text =data.firstName;
       lnameController.text = data.lastName;
        addressController.text = data.address;

        _checkInsertUpdate = "Update";
    }



    return  Scaffold(
        appBar: AppBar(
          title: Text(_checkInsertUpdate),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              SizedBox(height: 10),
              TextField(
                   controller: fnameController,
                decoration: InputDecoration(labelText: 'first name'),
              ),
              SizedBox(height: 10),
              TextField(
                   controller: lnameController,
                decoration: InputDecoration(labelText: 'last name'),
              ),
              SizedBox(height: 10),
              TextField(
                   controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _fakedata();
                    },
                    child: Text('GenerateData'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {

                      if(_checkInsertUpdate  == "Update"){
                        _updateData(data.id,fnameController.text,lnameController.text,addressController.text);
                      }
                      _insertData
                      (fnameController.text,lnameController.text,addressController.text);
                    },
                    child: Text(_checkInsertUpdate),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }


Future<void> _updateData(var id,String fName, String lName, String address) async {

  final updateData = MongoDbModel(
    id: id, firstName: fName, lastName: lName, address: address);
    await MongoDatabase.update(updateData).whenComplete(() => Navigator.pop(context));

}

Future<void> _insertData(String fName, String lName, String address) async {
    var _id = M.ObjectId(); // Create an instance of ObjectId
    final data = MongoDbModel(
        id: _id, firstName: fName, lastName: lName, address: address);
       var result = await MongoDatabase.insert(data);
       ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(
      content:Text("inserted Id" + _id.$oid)));
      _clearAll();
  }


void _clearAll(){
    fnameController.text = "";
    lnameController.text = "";
    addressController.text = "";
}

  void _fakedata(){
          setState(() {
            fnameController.text = faker.person.firstName();
            lnameController.text = faker.person.lastName();
            addressController.text = faker.address.streetAddress();
           

          });
  }
}