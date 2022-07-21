import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduling_app/models/appoinment.dart';
import '../backend/controllers/schedule_controller.dart';

class AllSessions extends StatelessWidget {
  const AllSessions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ScheduleController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Sessions'),
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
                          return Card(
                            color: Colors.black12,
                            child: ListTile(
                              title: Text(item.day,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(item.hour,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  )),
                              trailing: Text(item.minute,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  )),
                            ),
                          );
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
