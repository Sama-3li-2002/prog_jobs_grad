class Request {
  String? ProgId;
  String? fullName;
  String? email;
  String? city;
  String? fileUrl;
  String? uploadedFileName = '';
  String? specialization;
  String? university;
  String? skills;
  String? current_date;
  String? current_time;

  Request.submitJob(
    this.fullName,
    this.email,
    this.city,
    this.uploadedFileName,
    this.university,
    this.skills,
    this.specialization,
    this.current_time,
    this.current_date,
  );

  Request.fromJson(Map<String, dynamic> data) {
    ProgId = data['ProgId'];
    fullName = data['fullName'];
    email = data['email'];
    city = data['city'];
    fileUrl = data['fileUrl'];
    uploadedFileName = data['uploadedFileName'];
    specialization = data['specialization'];
    skills = data['skills'];
    university = data['university'];
    current_date = data['current_date'];
    current_time = data['current_time'];
  }
}
