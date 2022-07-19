// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

Notification notificationFromJson(String str) => Notification.fromJson(json.decode(str));

String notificationToJson(Notification data) => json.encode(data.toJson());

class Notification {
    Notification({
        this.userId,
        this.title,
        this.body,
        this.description,
    });

    String userId;
    String title;
    String body;
    String description;

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        userId: json["userId"],
        title: json["title"],
        body: json["body"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "title": title,
        "body": body,
        "description": description,
    };
}
