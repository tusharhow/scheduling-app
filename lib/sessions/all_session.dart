import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scheduling_app/models/appoinment.dart';
import '../backend/controllers/schedule_controller.dart';

class AllSessions extends StatelessWidget {
  const AllSessions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScheduleController());
    twinty24to12(String time) {
      final now = DateTime.now();
      final date = DateTime(now.year, now.month, now.day,
          int.parse(time), int.parse(time));
      return DateFormat('h:mm a').format(date);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Approved Sessions'),
      ),
      body: Column(
        children: [
          FutureBuilder<List<AppoinmentDate>>(
              future: controller.getAllAppointments(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          final item = snapshot.data[index];
                          // format month

                          var hour = twinty24to12(item.hour);

                          if (item.status == "approved") {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 120,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.black12,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Date: ${item.day}-${item.month}-${item.year}",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: Text(
                                                "Appoinment Status: ${item.status.toUpperCase()}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Hour: $hour",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text("Minutes: ${item.minute}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  )),
                            );
                          } else {
                            return Text('');
                          }
                        }),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}
