import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../../models/appoinment.dart';

class ScheduleController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

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

// show all appointments
  Future<List<AppoinmentDate>> getAllAppointments() async {
    final appointments = await _firestore.collection('appointments').get();
    final appointmentsList = appointments.docs.map((doc) {
      return AppoinmentDate.fromJson(doc.data());
    }).toList();
    update();
    return appointmentsList;
  }

  @override
  void onInit() {
    getAllAppointments();
    super.onInit();
  }
}
