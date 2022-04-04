class World{
  final String id;
  final String location;
  final String time;
  final String note;
  
  const World({required this.id,required this.location,required this.time,required this.note});

  factory World.fromJSON(Map<String, dynamic> data){
    return World(
      id: data['_id'], 
      location: data['location'],
       time: data['time'],
       note:data['note']
       );
  }
}