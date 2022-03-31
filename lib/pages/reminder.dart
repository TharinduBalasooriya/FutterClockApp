import 'package:clock_app/pages/reminder_form.dart';
import 'package:clock_app/pages/world_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../component/navBar.dart';

class Reminder extends StatefulWidget {
  static const String routeName = '/reminder';
  const Reminder({Key? key}) : super(key: key);

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reminders"),
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
            MaterialPageRoute(builder: (context) => const Reminder_form()),
          );
        },
      ),
      /*floatingActionButton:FloatingActionButton.extended(  
        onPressed: () {},  
        icon: Icon(Icons.save),  
        label: Text("Save"),  
      ), */
      body: (ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text("ss"),
            subtitle: Text("date"),
          ),
          Divider(),
          Slidable(
            // Specify a key if the Slidable is dismissible.
            key: ValueKey(0),

            // The start action pane is the one at the left or the top side.
            startActionPane: ActionPane(
              // A motion is a widget used to control how the pane animates.
              motion: ScrollMotion(),

              // A pane can dismiss the Slidable.
              // dismissible: DismissiblePane(onDismissed: () {}),

              // All actions are defined in the children parameter.
              children: [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  onPressed: null,
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: null,
                  backgroundColor: Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
                ),
              ],
            ),

            // The end action pane is the one at the right or the bottom side.
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  // An action can be bigger than the others.
                  flex: 2,
                  onPressed: null,
                  backgroundColor: Color(0xFF7BC043),
                  foregroundColor: Colors.white,
                  icon: Icons.archive,
                  label: 'View',
                ),
                SlidableAction(
                  onPressed: null,
                  backgroundColor: Color(0xFF0392CF),
                  foregroundColor: Colors.white,
                  icon: Icons.save,
                  label: 'Save',
                ),
              ],
            ),

            // The child of the Slidable is what the user sees when the
            // component is not dragged.
            child: const ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text("ss"),
              subtitle: Text("date"),
            ),
          ),
          Divider(),
        ],
      )),
      bottomNavigationBar: const NavBar(
        currItem: 3,
      ),
    );
  }
}
