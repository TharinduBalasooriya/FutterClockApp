import 'dart:convert';
import 'dart:developer';
import 'package:clock_app/model/worldclock_model.dart';
import 'package:http/http.dart' as http;

class WorldService{
  const WorldService();

  Future<List<World>> getWorld() async{
    var url=Uri.parse('https://clock-app-ctse.herokuapp.com/api/worldclock');
    late http.Response response;
    List<World> worldc=[];

    try {
      response = await http.get(url);
      if (response.statusCode==200){
        List<dynamic> worldData= jsonDecode(response.body);
        for(var item in worldData){
          worldc.add(World.fromJSON(item));
        }
      
      }else{
       return Future.error("Error Error,${response.statusCode}"); 
      }
    }catch(e){
      return Future.error(e.toString());
    }

  return worldc;
  }

//Add world time
  Future<World> createWorldtime(World world) async {
    final response = await http.post(
      Uri.parse('https://clock-app-ctse.herokuapp.com/api/worldclock'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "location": world.location,
        "time": world.time,
        "note": 'country note'
       
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return World.fromJSON(json.decode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to add world time.');
    }
  }

//Delete World Time
  Future<bool> deleteWorldclock(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://clock-app-ctse.herokuapp.com/api//worldclock/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {

    return true;
  } else {
    // If the server did not return a "200 OK response",
    // then throw an exception.
    throw Exception('Failed to delete .');
  }
}


}