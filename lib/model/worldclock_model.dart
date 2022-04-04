class World{
  final String id;
  final String location;
  final String time;
  
  const World({required this.id,required this.location,required this.time});

  factory World.fromJSON(Map<String, dynamic> data){
    return World(
      id: data['_id'], 
      location: data['location'],
       time: data['time'],
       );
  }
}