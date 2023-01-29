class AppointmentBean extends Object{
  int? id;
  String? title;
  String? description;
  String? appDate;
  String? appTime;

  @override
  String toString() {
    return 'AppointmentBean{id: $id, title: $title, description: $description, appDate: $appDate, appTime: $appTime}';
  }
}