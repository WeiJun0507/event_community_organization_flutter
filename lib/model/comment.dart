class PComment {
  String id;
  String student_name;
  String commentT;
  String postId;
  DateTime date;

  PComment(this.id, this.student_name, this.commentT, this.postId, this.date);

  PComment.fromJson(Map<String, dynamic> json)
      :
        id = json['id'],
        student_name = json['student_name'],
        commentT = json['commentT'],
        postId = json['postId'],
        date = json['date'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'student_name': student_name,
        'commentT': commentT,
        'postId': postId,
        'date': date,
      };
}