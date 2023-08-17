class Users {
  String? id;
  String? username;
  String? email;
  String? password;
  String? phone;
  int? age;
  String? specialization;
  String? about;
  String? imageUrl;

  Users();

  Users.signup(this.username, this.email, this.password, this.phone, this.age,
      this.specialization, this.about);

  Users.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    username = data['username'];
    email = data['email'];
    phone = data['phone'];
    age = data['age'];
    specialization = data['specialization'];
    about = data['about'];
    imageUrl = data['imageUrl'];
  }
}
