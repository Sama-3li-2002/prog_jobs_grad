class Users {
  String? id;
  String? username;
  String? email;
  String? password;
  String? phone;
  int? age;
  String? specialization;
  String? about;
  String? fullName;
  String? city;
  String? university;
  String? skills;
  String imageUrl =
      'https://firebasestorage.googleapis.com/v0/b/prog-jobs-grad.appspot.com/o/profile_images%2FwithoutImagePerson.jpg?alt=media&token=f3437ef3-c44d-41d4-bdbb-9d4619d77071';

  Users();

  Users.signup(
    this.username,
    this.email,
    this.password,
    this.phone,
    this.age,
    this.specialization,
    this.about,
  );

  Users.submitJob(
    this.fullName,
    this.email,
    this.city,
    this.university,
    this.skills,
    this.specialization,
  );

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
