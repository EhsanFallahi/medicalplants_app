enum Roll{
  User,
  Admin
}
class Person {
  int id;
  String fullName;
  String userName;
  String password;
  String image;
  Roll roll;

  Person(
      {this.id,
        this.fullName,
        this.userName,
        this.password,
        this.image,
        this.roll});

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    userName = json['user_name'];
    password = json['password'];
    image = json['image'];
    roll = json['roll']=='user'?Roll.User:Roll.Admin;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['user_name'] = this.userName;
    data['password'] = this.password;
    data['image'] = this.image;
    data['roll'] =this.roll==Roll.User?'user':'admin';
    return data;
  }
}