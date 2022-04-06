import 'package:clock_app/model/alarm_model.dart';
import 'package:clock_app/provider/alarm_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:clock_app/pages/alarm.dart';
import '../services/alarm_service.dart';

class AddAlarmform extends StatefulWidget {
  static const String routeName = '/addAlarm';
  final AlarmService _alarmService;
  const AddAlarmform({Key? key})
      : _alarmService = const AlarmService(),
        super(key: key);

  @override
  State<AddAlarmform> createState() => _AddAlarmformState();
}

class _AddAlarmformState extends State<AddAlarmform> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AlarmService _alarmService;
  @override
  void initState() {
    super.initState();
    _alarmService = widget._alarmService;
  }

  final TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);
  final hourController = TextEditingController();
  final minController = TextEditingController();

  List<bool> isSelected = [true, false];
  int _hr = 00;
  int _min = 00;
  String _ampm = 'AM';

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
    'RingingTone1': true,
    'RinginTone2': false,
  };

  Future<void> _showTimePicker() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      _ampm = result.hour < 12 ? 'AM' : 'PM';
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
              _hr = int.parse(value!);
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
              _min = int.parse(value!);
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
        title: const Text("Add Alarm"),
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

                Alarm alarm = Alarm(
                    id: "",
                    hour: _hr,
                    minute: _min,
                    ampm: _ampm,
                    days: selectedDays,
                    sound: selectedTone);

                print(alarm.days);
                Alarm createdAlarm =
                    await Provider.of<AlarmProvider>(context, listen: false)
                        .addAlarm(alarm);

                if (createdAlarm != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Alarm created successfully'),
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
