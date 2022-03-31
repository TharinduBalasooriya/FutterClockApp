// ignore_for_file: unnecessary_new

import 'package:clock_app/pages/world_clock.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

import '../component/navBar.dart';

class Reminder_form extends StatefulWidget {
  static const String routeName = '/reminder_form';
  const Reminder_form({Key? key}) : super(key: key);

  @override
  State<Reminder_form> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder_form> {
  bool widgetVisible = true;
  bool isActive = true;

  void showWidget() {
    setState(() {
      widgetVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      widgetVisible = false;
    });
  }

  var _currencies = [
    "Food",
    "Transport",
    "Personal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];
  final List<bool> _selections = List.generate(3, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Reminder"),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.done_all_rounded),
            label: Text(''),
            onPressed: () {},
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 0, 217, 246),
        foregroundColor: Colors.white,
        onPressed: () => {},
      ),
      /*floatingActionButton:FloatingActionButton.extended(  
        onPressed: () {},  
        icon: Icon(Icons.save),  
        label: Text("Save"),  
      ), */
      // ignore: unnecessary_new
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: new Column(children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.pending_actions),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: "",
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Card(
              child: SwitchListTile(
                title: const Text(
                  'Remind me on a day',
                  style: TextStyle(
                    color: Color.fromARGB(255, 235, 237, 238),
                  ),
                ),
                value: widgetVisible,
                activeColor: const Color.fromARGB(255, 0, 217, 246),
                inactiveTrackColor: Color.fromARGB(255, 250, 250, 250),
                onChanged: (showWidget) {
                  setState(() {
                    widgetVisible = showWidget;
                  });
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 2, bottom: 20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Column(
                children: <Widget>[
                  Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: widgetVisible,
                      child: Container(
                          height: 100.0,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 2, bottom: 20),
                          child: Center(
                              child: Column(children: <Widget>[
                            DateTimePicker(
                              type: DateTimePickerType.dateTimeSeparate,
                              dateMask: 'd MMM, yyyy',
                              initialValue: DateTime.now().toString(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              icon: const Icon(Icons.event),
                              dateLabelText: 'Date',
                              timeLabelText: "Hour",
                              selectableDayPredicate: (date) {
                                // Disable weekend days to select from the calendar
                                if (date.weekday == 6 || date.weekday == 7) {
                                  return false;
                                }

                                return true;
                              },
                              onChanged: (val) => print(val),
                              validator: (val) {
                                // ignore: avoid_print
                                print(val);
                                return null;
                              },
                              onSaved: (val) => print(val),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text("Repeat"),
                                ],
                              ),
                            )
                          ])))),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Priority"),
                ToggleButtons(
                  color:  const Color.fromARGB(255, 0, 217, 246),
                  borderColor: Color.fromARGB(255, 151, 148, 148),
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    const Text(
                      "!",
                      style: TextStyle(
                          color: Color.fromARGB(255, 211, 83, 83),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "!!",
                      style: TextStyle(
                          color:Color.fromARGB(255, 211, 83, 83),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "!!!",
                      style: TextStyle(
                          color: Color.fromARGB(255, 211, 83, 83),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                  isSelected: _selections,
                  onPressed: (int index) {
                    setState(() {
                      _selections[index] != _selections[index];
                    });
                  },
                )
              ],
            ),
          ),
          const Divider(
            height: 1.0,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: const [
                Text("Notes"),
                TextField(
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 3,
                  maxLines: 5,
                ),
              ]),
            ),
          )
        ]),
      ),
      bottomNavigationBar: const NavBar(
        currItem: 3,
      ),
    );
  }
}
