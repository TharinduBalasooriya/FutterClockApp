import 'package:flutter/material.dart';
import '../model/worldclock_model.dart';
import '../services/world_service.dart';

class WorldtimeProvider extends ChangeNotifier{
late WorldService _worldService;
List<World> _worldtimes=[];
WorldtimeProvider(){
  _worldService=WorldService();
}

Future<List<World>> getWorld() async{
  _worldtimes=await _worldService.getWorld();
  notifyListeners();
  return _worldtimes;
}

Future<bool> deleteWorldclock(String id) async{
  bool result =await _worldService.deleteWorldclock(id);
  notifyListeners();
  return result;
}

Future<World> createWorldtime(World world) async{
  World result =await _worldService.createWorldtime(world);
  notifyListeners();
  return result;
}

}