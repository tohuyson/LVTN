import 'notify_type.dart';

class ListNotify {
  List<Notify>? notify;

  ListNotify({this.notify});

  ListNotify.fromJson(Map<String, dynamic> json) {
    if (json['notify'] != null) {
      notify = new List.generate(0, (index) => new Notify());
      json['notify'].forEach((v) {
        notify!.add(new Notify.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notify != null) {
      data['notify'] = this.notify!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notify {
  late int? id;
  late String? title;
  late int? notificationTypeId;
  late int? userId;
  late String? body;
  late String? createdAt;
  late String? updatedAt;
  late NotifyType? notifyType;

  Notify(
      {this.id,
      this.title,
      this.notificationTypeId,
      this.userId,
      this.body,
      this.createdAt,
      this.updatedAt,
      this.notifyType});

  Notify.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    notificationTypeId = json['notification_type_id'];
    userId = json['user_id'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    notifyType = json['notify_type'] != null
        ? new NotifyType.fromJson(json['notify_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['notification_type_id'] = this.notificationTypeId;
    data['user_id'] = this.userId;
    data['body'] = this.body;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.notifyType != null) {
      data['notify_type'] = this.notifyType!.toJson();
    }
    return data;
  }
}
