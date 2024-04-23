import 'dart:developer';

import 'package:http_methods_poc/dbHelper/constant.dart';
import 'package:http_methods_poc/model/MongoDBModel.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase{

static var db,userCollection;
static connect() async{
  db =await Db.create(MONGO_CONN_URL);
  await db.open();
  inspect(db);
  userCollection = db.collection(USER_COLLECTION);
}



static Future<void>update(MongoDbModel data) async{
  var result = await userCollection.findOne({"_id":data.id});
  result ["firstName"] =data .firstName;
   result ["lastName"] =data .lastName;
    result ["address"] =data .address;

    var responce = userCollection.save(result);
    inspect(responce);
}


static Future<List<Map<String,dynamic>>> getData() async{
final arrData = await userCollection.find().toList();
return arrData;
}

static Future<String> insert(MongoDbModel data)async{
  try{
    var result = await userCollection.insertOne(data.toJson());
       
       if(result.isSuccess){

        return "data insert";

       }else{
        return "not insert";
       }     
  }catch(e){
    print(e.toString());
    return e.toString();
  }
}
}