// ignore_for_file: unnecessary_new

import 'package:clock_app/pages/world_clock.dart';
import 'package:clock_app/services/reminder_service.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:clock_app/model/reminder_model.dart';
import 'package:clock_app/provider/reminder_provider.dart';
import 'package:provider/provider.dart';

import '../component/navBar.dart';

class Reminder_form extends StatefulWidget {
  static const String routeName = '/reminder_form';
  const Reminder_form({Key? key}) : super(key: key);

  @override
  State<Reminder_form> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder_form> {
  ReminderService remindeservice = ReminderService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final noteController = TextEditingController();
  String _name = '';
  String _note = '';
  String _datetime = "";
  String _priority = "";
  String _repeat = "";

  bool widgetVisible = true;
  bool isActive = true;
  Map<String, bool> days = {
    'Never': false,
    'Every Day': false,
    'Every Week': false,
    'Every 2 Weeks': false,
    'Every Month': false,
    'Every Year': false,
  };

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

  final List<bool> _selections = List.generate(3, (_) => false);
  Future<void> _showDaysDialog() async {
    Map<String, bool> dialogDays = days;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Country List'),
            content: StatefulBuilder(
              builder: (context, setState) {
                return SizedBox(
                  height: 400.0, // Change as per your requirement
                  width: 400.0, // Change as per your requirement
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: days.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(dialogDays.keys.toList()[index]),
                        trailing: IconButton(
                          icon: Icon(Icons.check,
                              color:
                                  dialogDays[dialogDays.keys.elementAt(index)]!
                                      ? Colors.blue
                                      : Colors.grey),
                          onPressed: () {
                            setState(() {
                              (dialogDays.keys.toList()[index]);
                              var val =
                                  dialogDays[dialogDays.keys.elementAt(index)];
                              dialogDays[dialogDays.keys.elementAt(index)] =
                                  !val!;

                              if (index == 0) {
                                _repeat = "Never";
                              } else if (index == 1) {
                                _repeat = "Every Day";
                              } else if (index == 2) {
                                _repeat = "Every Week";
                              } else if (index == 3) {
                                _repeat = "Every 2 Weeks";
                              } else if (index == 3) {
                                _repeat = "Every Month";
                              } else {
                                _repeat = "Every Year";
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            //content: setupAlertDialoadContainer(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Reminder"),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.done_all_rounded),
            label: Text(''),
            onPressed: () async {
              _formKey.currentState?.save();

              print(_datetime);
              print(_name);
              print(_note);
              print(_priority);
              print(_repeat);

              Reminder reminder = Reminder(
                id: "",
                name: _name,
                date: _datetime,
                time: "",
                repeat: _repeat,
                priority: _priority,
                note: _note,
              );

              
               Reminder result  = await Provider.of<ReminderProvider>(context, listen: false).addReminder(reminder);

              if (result  != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Reminder created successfully'),
                  ),
                );
                Navigator.pop(context);

              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Error creating alarm'),
                  ),
                );
              }
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: new Column(children: <Widget>[
            new ListTile(
              leading: const Icon(Icons.pending_actions),
              title: new TextFormField(
                controller: nameController,
                validator: (text) {
                  return null;
                },
                decoration: new InputDecoration(
                  hintText: "",
                ),
                onSaved: (value) {
                  _name = value!;
                },
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
              margin: const EdgeInsets.only(top: 2),
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
                            height: 80.0,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 2),
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
                                    if (date.weekday == 6 ||
                                        date.weekday == 7) {
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
                                  onSaved: (val) {
                                    _datetime = val!;
                                  }),
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
                  const Text("Repeat",style: TextStyle(fontSize: 15)),
                  IconButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    color: Colors.white,
                    onPressed: () {
                      _showDaysDialog();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Priority",style: TextStyle(fontSize: 15),),
                  ToggleButtons(
                    color: const Color.fromARGB(255, 0, 217, 246),
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
                            color: Color.fromARGB(255, 211, 83, 83),
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
                        _selections[index] = !_selections[index];
                      });
                      if (index == 0) {
                        _priority = "!";
                      } else if (index == 1)
                        _priority = "!!";
                      else
                        _priority = "!!!";
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
                child: Column(children: [
                  Text("Notes",style: TextStyle(fontSize: 15)),
                  TextFormField(
                    controller: noteController,
                    validator: (text) {
                      return null;
                    },
                    onSaved: (value) {
                      _note = value!;
                    },
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
      ),
      bottomNavigationBar: const NavBar(
        currItem: 3,
      ),
    );
  }
}
