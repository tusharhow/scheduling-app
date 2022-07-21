import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/appoinment.dart';
import '../../models/notification.dart';

class ScheduleController extends GetxController {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addAppointment(AppoinmentDate appointment) async {
    final response = _firestore.collection('appointments').add({
      "status": "pending",
      'year': appointment.year,
      'month': appointment.month,
      'day': appointment.day,
      'hour': appointment.hour,
      'minute': appointment.minute,
      'second': appointment.second,
    });
    if (response != null) {
      print('Appointment added successfully');
    } else {
      print('Error adding appointment');
    }
  }

  // my booked appointments
  Future<List<AppoinmentDate>> getMyAppointments() async {
    final userId = Get.find<String>();
    final appointments = await _firestore
        .collection('appointments')
        .where('userId', isEqualTo: userId)
        .get();
    final appointmentsList = appointments.docs.map((doc) {
      return AppoinmentDate.fromJson(doc.data());
    }).toList();
    return appointmentsList;
  }

// show all appointments
  Future<List<AppoinmentDate>> getAllAppointments() async {
    final appointments = await _firestore.collection('appointments').get();
    final appointmentsList = appointments.docs.map((doc) {
      return AppoinmentDate.fromJson(doc.data());
    }).toList();
    return appointmentsList;
  }

  @override
  void onInit() {
    getAllAppointments();
    super.onInit();
  }
}
