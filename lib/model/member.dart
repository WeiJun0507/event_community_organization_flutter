class Member {
  String id;
  String username;
  String email;
  String userType;

  Member(this.id, this.username, this.email, this.userType);

  Member.fromJson(Map<String, dynamic> json)
  : id = json['id'],
    username = json['username'],
    email = json['email'],
    userType = json['userType'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'username': username,
        'email': email,
        'userType': userType,
      };
}
