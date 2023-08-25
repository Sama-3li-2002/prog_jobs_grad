class Company {
  String? companyName;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? managerName;
  String? facebookAccount;
  String? twitterAccount;
  String? InstagramAccount;
  String? about;
  String? image;

  String? managerImage;

  Company({
    this.companyName,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.managerName,
    this.facebookAccount,
    this.twitterAccount,
    this.InstagramAccount,
    this.about,
    this.image,
    this.managerImage,
  });

  Company.signUP(
      this.companyName,
      this.email,
      this.password,
      this.phone,
      this.address,
      this.managerName,
      this.facebookAccount,
      this.twitterAccount,
      this.InstagramAccount,
      this.about,
      this.image,
      this.managerImage);

  Company.fromMap(Map<String, dynamic> map) {
    this.companyName = map['companyName'];
    this.email = map['email'];
    this.phone = map['phone'];
    this.address = map['address'];
    this.managerName = map['managerName'];
    this.facebookAccount = map['facebookAccount'];
    this.twitterAccount = map['twitterAccount'];
    this.InstagramAccount = map['InstagramAccount'];
    this.about = map['about'];
    this.image = map['image'];
    this.managerImage = map['managerImage'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['companyName'] = this.companyName;
    map['email'] = this.email;
    map['phone'] = this.phone;
    map['address'] = this.address;
    map['managerName'] = this.managerName;
    map['facebookAccount'] = this.facebookAccount;
    map['twitterAccount'] = this.twitterAccount;
    map['InstagramAccount'] = this.InstagramAccount;
    map['about'] = this.about;
    map['image'] = this.image;
    map['managerImage'] = this.managerImage;
    return map;
  }
}
