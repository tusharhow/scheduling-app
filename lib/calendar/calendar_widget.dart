import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scheduling_app/backend/controllers/schedule_controller.dart';
import 'package:scheduling_app/models/appoinment.dart';

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
              // Align(
              //   alignment: AlignmentDirectional(0, 0),
              //   child: FlutterFlowCalendar(
              //     color: FlutterFlowTheme.of(context).primaryColor,
              //     weekFormat: false,
              //     weekStartsMonday: false,
              //     initialDate: getCurrentTimestamp,
              //     onChange: (DateTimeRange newSelectedDate) {
              //       setState(
              //         () => calendarSelectedDay = newSelectedDate
              //       );
              //     },
              //     titleStyle: FlutterFlowTheme.of(context).bodyText1,
              //     dayOfWeekStyle: FlutterFlowTheme.of(context).bodyText1,
              //     dateStyle: FlutterFlowTheme.of(context).subtitle1.override(
              //           fontFamily: 'Poppins',
              //           fontSize: 14,
              //         ),
              //     selectedDateStyle: FlutterFlowTheme.of(context).subtitle1,
              //     inactiveDateStyle:
              //         FlutterFlowTheme.of(context).subtitle2.override(
              //               fontFamily: 'Poppins',
              //               fontSize: 12,
              //               fontWeight: FontWeight.normal,
              //             ),
              //     locale: FFLocalizations.of(context).languageCode,
              //   ),
              // ),
              SizedBox(
                height: 300,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _showDatePicker(context);
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
                  onDateTimeChanged: (DateTime val) {
                    setState(() {
                      _chosenDateTime = val;
                      print(_chosenDateTime);
                    });
                  }),
            ),
            ElevatedButton(
              onPressed: () {
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
              },
              child: Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
