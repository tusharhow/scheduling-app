// To parse this JSON data, do
//
//     final appoinmentDate = appoinmentDateFromJson(jsonString);

import 'dart:convert';

AppoinmentDate appoinmentDateFromJson(String str) => AppoinmentDate.fromJson(json.decode(str));

String appoinmentDateToJson(AppoinmentDate data) => json.encode(data.toJson());

class AppoinmentDate {
    AppoinmentDate({
        this.year,
        this.month,
        this.day,
        this.hour,
        this.minute,
        this.second,
      
    });

    String year;
    String month;
    String day;
    String hour;
    String minute;
    String second;

    factory AppoinmentDate.fromJson(Map<String, dynamic> json) => AppoinmentDate(
        year: json["year"],
        month: json["month"],
        day: json["day"],
        hour: json["hour"],
        minute: json["minute"],
        second: json["second"],
    );

    Map<String, dynamic> toJson() => {
        "year": year,
        "month": month,
        "day": day,
        "hour": hour,
        "minute": minute,
        "second": second,
      
    };
}
