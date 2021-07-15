class RegisterEvent {
  String id;
  String s_id;
  String s_name;
  String eventName;
  String o_name;
  String venue;
  DateTime date;

  RegisterEvent(this.id, this.s_id, this.s_name, this.eventName, this.o_name,
      this.venue, this.date);

  RegisterEvent.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        s_name = json['s_name'],
        s_id = json['s_id'],
        eventName = json['eventName'],
        o_name = json['o_name'],
        venue = json['venue'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'id': id,
        's_name': s_name,
        's_id': s_id,
        'eventName': eventName,
        'o_name': o_name,
        'venue': venue,
        'date': date,
      };
}
