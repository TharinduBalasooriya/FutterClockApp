import 'package:clock_app/pages/newnote.dart';
import 'package:clock_app/pages/world_clock.dart';
import 'package:clock_app/widgets/noteCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../component/navBar.dart';
import '../services/note_service.dart';

class ToDoList extends StatefulWidget {
  static const String routeName = '/todo';
  final NoteService _noteService;
  const ToDoList({Key? key})
      : _noteService = const NoteService(),
        super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  late NoteService _noteService;
  @override
  void initState() {
    super.initState();
    _noteService = widget._noteService;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, value, Widget? child) => Scaffold(
        appBar: AppBar(
          title: const Text("My Notes"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.language),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, WorldClock.routeName, (r) => false);
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: const Color.fromARGB(255, 0, 217, 246),
          foregroundColor: Colors.white,
          onPressed: () {
            // handle the press
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewNote()),
            );
          },
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: FutureBuilder(
              future: _noteService.getNotes(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return NoteCardWidget(note: snapshot.data[index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [CircularProgressIndicator()],
                  ),
                );
              }),
          // Stack(
          //   children: [
          //     Column(
          //       children: [
          //         Expanded(
          //           child: ListView(
          //             children: [

          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //     Positioned(
          //         bottom: 24.0,
          //         right: 0.0,
          //         child: GestureDetector(
          //           onTap: () {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => const NewNote()),
          //             );
          //           },
          //           child: Container(
          //               width: 60.0,
          //               height: 60.0,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(20.0),
          //                 color: Colors.grey,
          //               ),
          //               child: const Icon(Icons.add)),
          //         )),
          //   ],
        ),
        bottomNavigationBar: const NavBar(
          currItem: 2,
        ),
      ),

      // ),
    );
  }
}
