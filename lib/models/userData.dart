class UserData {
  String uid;
  String email;
  String username;

  UserData({required this.uid, required this.email, required this.username});

  factory UserData.fromjson(Map<String, dynamic> json) {
    return UserData(
        uid: json['uid'], email: json['email'], username: json['username']);
  }

  Map<String, dynamic> toJson() {
        return {
          "uid": this.uid,
          "email": this.email,
          "username":this.username
        };
      }
}
