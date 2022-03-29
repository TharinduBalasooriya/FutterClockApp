import 'package:clock_app/model/alarm_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleAlarm extends StatelessWidget {
  final Alarm alarm;
  const SingleAlarm({Key? key, required this.alarm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          child: Container(
            margin: const EdgeInsets.all(6),
            child: SwitchListTile(
              activeColor: const Color.fromARGB(255, 0, 217, 246),
              secondary: const Icon(
                Icons.alarm,
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  Text(
                    alarm.hour.toString() + ":" + alarm.minute.toString(),
                    style: GoogleFonts.lato(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                   Expanded(child: Container()),
                  Text(
                    "AM",
                    style: GoogleFonts.lato(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              subtitle: Container(
                child: Text(
                  alarm.days.join(", "),
                  style: GoogleFonts.roboto(fontSize: 15),
                ),
                margin: const EdgeInsets.only(top: 2.0),
              ),
              onChanged: (bool value) {
                value = !value;
              },
              value: true,
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}



// ListView(
//         children: <Widget>[
//           Material(
//             child: Container(
//               margin: const EdgeInsets.all(6),
//               child: SwitchListTile(
//                 activeColor: const Color.fromARGB(255, 0, 217, 246),
//                 secondary: const Icon(
//                   Icons.alarm,
//                 ),
//                 title: Row(
//                   crossAxisAlignment: CrossAxisAlignment.baseline,
//                   textBaseline: TextBaseline.alphabetic,
//                   children: <Widget>[
//                     Text(
//                       "09:30",
//                       style: GoogleFonts.lato(
//                         fontSize: 48,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ],
//                 ),
//                 subtitle: Container(
//                   child: Text(
//                     "Weekends",
//                     style: GoogleFonts.roboto(
//                       fontSize: 15
//                     ),
//                   ),
//                   margin: const EdgeInsets.only(top: 2.0),
//                 ),
//                 onChanged: (bool value) {
//                   value = !value;
//                 },
//                 value: true,
//               ),
//             ),
//           ),
//           const Divider(),
//         ],
//       )