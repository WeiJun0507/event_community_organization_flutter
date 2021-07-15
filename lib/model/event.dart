class Event {
  String id;
  String o_id;
  String o_name;
  String imagePath;
  String eventName;
  String description;
  String eventRequirement;
  String termsAndC;
  String venue;
  DateTime date;

  Event(this.id, this.o_id, this.o_name, this.imagePath, this.eventName,this.description, this.eventRequirement, this.termsAndC, this.venue, this.date);

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        o_id = json['o_id'],
        o_name = json['o_name'],
        imagePath = json['imagePath'],
        eventName = json['eventName'],
        description = json['description'],
        eventRequirement = json['eventRequirement'],
        termsAndC = json['termsAndC'],
        venue = json['venue'],
        date = DateTime.parse(json['date'].toDate().toString());

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'o_id': o_id,
        'o_name': o_name,
        'imagePath': imagePath,
        'eventName': eventName,
        'description': description,
        'eventRequirement': eventRequirement,
        'termsAndC': termsAndC,
        'venue': venue,
        'date': date,
      };
}