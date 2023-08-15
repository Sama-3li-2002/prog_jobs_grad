class Users {
  String? username;
  String? email;
  String? password;
  String? phone;
  int? age;
  String? specialization;
  String? about;
  String imageUrl = 'assets/images/prof1.png';

  Users.signup(this.username, this.email, this.password, this.phone, this.age,
      this.specialization, this.about);
}
