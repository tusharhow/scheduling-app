import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scheduling_app/backend/controllers/schedule_controller.dart';
import 'package:scheduling_app/models/appoinment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../flutter_flow/flutter_flow_calendar.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarWidget extends StatefulWidget {
  CalendarWidget({Key key, this.desc, this.time, this.title}) : super(key: key);
  String title;
  String desc;
  String time;
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTimeRange calendarSelectedDay;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(ScheduleController());
  DateTime _chosenDateTime;

  @override
  void initState() {
    super.initState();
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    init();
  }

  String date;
  String month;
  String year;

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      date = prefs.getString('date');
      month = prefs.getString('month');
      year = prefs.getString('year');
    });
    print("date: $date");
    print("month: $month");
    print("year: $year");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.home,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 30,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        title: Text(
          FFLocalizations.of(context).getText(
            '5n0xn5g4' /* Page Title */,
          ),
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [
          FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30,
            ),
            onPressed: () async {
              context.pushNamed('schedule');
            },
          ),
        ],
        centerTitle: false,
        elevation: 2,
      ),
      backgroundColor: Color(0xFF5CFFC9),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 30,
              ),
              if (date != null)
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Container(
                        child: Text(
                            'You have an appointment on\n$date-$month-$year',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2050, 3, 14),
                focusedDay: DateTime.now(),
                currentDay: date == null
                    ? DateTime.now()
                    : DateTime.utc(
                        int.parse(year), int.parse(month), int.parse(date)),
              ),
              if (date == null)
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showDatePicker(context);
                      });
                    },
                    child: Text('Book Appointment'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker(ctx) {
    setState(() {
      showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: 450,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 350,
                child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    dateOrder: DatePickerDateOrder.dmy,
                    onDateTimeChanged: (DateTime val) async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      setState(() {
                        _chosenDateTime = val;
                        prefs.setString('date', _chosenDateTime.day.toString());
                        prefs.setString(
                            'month', _chosenDateTime.month.toString());
                        prefs.setString(
                            'year', _chosenDateTime.year.toString());
                      });
                    }),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    controller
                        .addAppointment(
                          AppoinmentDate(
                            month: _chosenDateTime.month.toString(),
                            year: _chosenDateTime.year.toString(),
                            day: _chosenDateTime.day.toString(),
                            hour: _chosenDateTime.hour.toString(),
                            minute: _chosenDateTime.minute.toString(),
                            second: _chosenDateTime.second.toString(),
                          ),
                        )
                        .then((value) => {
                              Navigator.of(ctx).pop(),
                              scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text('Appointment Added'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
                              ),
                            });
                  });
                },
                child: Text('Book Appointment'),
              ),
            ],
          ),
        ),
      );
    });
  }
}
