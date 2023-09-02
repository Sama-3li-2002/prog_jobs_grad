class Company {
  String? id;
  String? companyName;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? managerName;
  String? about;
  String? image;
  String? managerImage;

  Company({
    this.id,
    this.companyName,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.managerName,
    this.about,
    this.image,
    this.managerImage,
  });

  Company.notification(
    this.companyName,
    this.image,
    this.address,
  );

  Company.signUP(
      this.companyName,
      this.email,
      this.password,
      this.phone,
      this.address,
      this.managerName,
      this.about,
      this.image,
      this.managerImage);

  Company.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.companyName = map['companyName'];
    this.email = map['email'];
    this.phone = map['phone'];
    this.address = map['address'];
    this.managerName = map['managerName'];
    this.about = map['about'];
    this.image = map['image'];
    this.managerImage = map['managerImage'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id;
    map['companyName'] = this.companyName;
    map['email'] = this.email;
    map['phone'] = this.phone;
    map['address'] = this.address;
    map['managerName'] = this.managerName;
    map['about'] = this.about;
    map['image'] = this.image;
    map['managerImage'] = this.managerImage;
    return map;
  }
}
