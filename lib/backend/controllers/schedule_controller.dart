import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/appoinment.dart';
import '../../models/notification.dart';

class ScheduleController extends GetxController {
  final _firestore = FirebaseFirestore.instance;

// add new appointment date to the database

  // // give notification to the user when the appointment is scheduled
  // Future<void> notifyUser(String userId, String message) async {
  //   final user = await _firestore.collection('users').doc(userId).get();
  //   final notification = Notification(
  //     title: 'Appointment Scheduled',
  //     body: message,
  //     userId: userId,
  //   );
  //   await _firestore.collection('notifications').add(notification.toJson());
  //   await _firestore.collection('users').doc(userId).update({
  //     'notification': notification.toJson(),
  //   });
  // }
// add new appointment date to the database
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
