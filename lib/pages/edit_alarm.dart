import 'package:clock_app/model/alarm_model.dart';
import 'package:clock_app/services/alarm_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../provider/alarm_provider.dart';

class EditAlarm extends StatefulWidget {
  static const String routeName = '/editAlarm';
  final String _alarmId;
  EditAlarm({Key? key, required String alarmId})
      : _alarmId = alarmId,
        super(key: key);

  @override
  State<EditAlarm> createState() => _EditAlarmState();
}

class _EditAlarmState extends State<EditAlarm> {
  late String alarmId;
  late AlarmService _alarmService;
  late Alarm alarm;
  final hourController = TextEditingController();
  final minController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  Map<String, bool> days = {
    'Monday': true,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
    'Sunday': false,
  };

  Map<String, bool> rigingTones = {
    'RingingTone1': false,
    'RinginTone2': false,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    alarmId = widget._alarmId;
    _alarmService = const AlarmService();
    getAlarmDetails();
  }

  Future<void> getAlarmDetails() async {
    alarm = await _alarmService.getAlarmById(alarmId);

    hourController.value = hourController.value = TextEditingValue(
      text: alarm.hour.toString(),
      selection: TextSelection.fromPosition(
        TextPosition(offset: alarm.hour.toString().length),
      ),
    );

    minController.value = TextEditingValue(
      text: alarm.minute.toString(),
      selection: TextSelection.fromPosition(
        TextPosition(offset: alarm.minute.toString().length),
      ),
    );

    alarm.days.forEach((element) {
      switch (element) {
        case 'Monday':
          days['Monday'] = true;
          break;
        case 'Tuesday':
          days['Tuesday'] = true;
          break;
        case 'Wednesday':
          days['Wednesday'] = true;
          break;
        case 'Thursday':
          days['Thursday'] = true;
          break;
        case 'Friday':
          days['Friday'] = true;
          break;
        case 'Saturday':
          days['Saturday'] = true;
          break;
        case 'Sunday':
          days['Sunday'] = true;
          break;
        default:
          days['Monday'] = true;
      }
    });

    rigingTones.keys.contains(alarm.sound)
        ? rigingTones[alarm.sound] = true
        : rigingTones['RingingTone1'] = true;

    setState(() {});
  }

  Future<void> _showTimePicker() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      alarm.ampm = result.hour < 12 ? 'AM' : 'PM';
      hourController.value = TextEditingValue(
        text: result.hour.toString(),
        selection: TextSelection.fromPosition(
          TextPosition(offset: result.hour.toString().length),
        ),
      );

      minController.value = TextEditingValue(
        text: result.minute.toString(),
        selection: TextSelection.fromPosition(
          TextPosition(offset: result.minute.toString().length),
        ),
      );
    }
  }

  Widget _buildTimeField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            "Time",
            style: GoogleFonts.lato(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: TextFormField(
            controller: hourController,
            validator: (text) {
              return null;
            },
            maxLength: 2,
            decoration:
                const InputDecoration(counterText: "", hintText: "00hr"),
            onSaved: (value) {
              alarm.hour = int.parse(value!);
            },
          ),
        ),
        const Flexible(
          child: Text(":"),
        ),
        Flexible(
          child: TextFormField(
            controller: minController,
            validator: (text) {
              return null;
            },
            onSaved: (value) {
              alarm.minute = int.parse(value!);
            },
            maxLength: 2,
            decoration:
                const InputDecoration(counterText: "", hintText: "00min"),
          ),
        ),
        Expanded(child: Container()),
        ElevatedButton(
          onPressed: _showTimePicker,
          child: const Text('SELECT TIME'),
        ),
      ],
    );
  }

  Widget _buildRepeatPicker() {
    return Card(
      child: ListTile(
        title: const Text("Repeat Days"),
        subtitle: Text(
          "Select days to repeat alarm",
          style: GoogleFonts.lato(
            fontSize: 15,
            fontWeight: FontWeight.w800,
          ),
        ),
        trailing: IconButton(
            onPressed: () async {
              await _showDaysDialog();
            },
            icon: const Icon(Icons.arrow_forward_ios)),
      ),
    );
  }

  Widget _buildSoundPicker() {
    return Card(
      child: ListTile(
        title: const Text("Select sound"),
        subtitle: const Text("Sound"),
        trailing: IconButton(
            onPressed: () async {
              await _showToneDialog();
            },
            icon: const Icon(Icons.arrow_forward_ios)),
      ),
    );
  }

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
                        title: Text("Every " + dialogDays.keys.toList()[index]),
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

  Future<void> _showToneDialog() async {
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
                    itemCount: rigingTones.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title:
                            Text("Every " + rigingTones.keys.toList()[index]),
                        trailing: IconButton(
                          icon: Icon(Icons.check,
                              color: rigingTones[
                                      rigingTones.keys.elementAt(index)]!
                                  ? Colors.blue
                                  : Colors.grey),
                          onPressed: () {
                            setState(() {
                              rigingTones.updateAll((key, value) => false);
                              rigingTones[rigingTones.keys.elementAt(index)] =
                                  true;
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
        title: const Text("Edit Alarm"),
        actions: [
          TextButton(
              onPressed: () async {
                _formKey.currentState?.save();

                List<String> selectedDays = [];
                days.forEach((key, value) {
                  if (value) {
                    selectedDays.add(key);
                  }
                });

                String selectedTone = "";
                rigingTones.forEach((key, value) {
                  if (value) {
                    selectedTone = key;
                  }
                });

                alarm.days = selectedDays;
                alarm.sound = selectedTone;

                Alarm updatedAlarm =
                    await Provider.of<AlarmProvider>(context, listen: false)
                        .updateAlarm(alarm);

                if (updatedAlarm != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Alarm updated successfully'),
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
              child: Text("SAVE",
                  style: GoogleFonts.lato(fontSize: 17, color: Colors.white)))
        ],
      ),
      body: (SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                child: _buildTimeField(),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: _buildRepeatPicker(),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: _buildSoundPicker(),
              ),
            ],
          ),
        ),
      ))),
    );
  }
}
