class FirebaseModel {
  String? id;
  final String? username;
  final String? dateofBirth;
  final String? email;
  final String? role;

  FirebaseModel(
      {this.id, this.username, this.dateofBirth, this.email, this.role});

  static FirebaseModel fromjson(Map<String, dynamic> json) {
    return FirebaseModel(
        id: json["uid"],
        username: json["email"],
        dateofBirth: json["DateofBirth"],
        email: json["email"],
        role: json["role"]);
  }
}
