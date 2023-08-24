class Jobs {
  String? id;
  String? job_id;
  String? job_image;
  String? job_name;
  String? company_name;
  String? salary;
  String? job_description;
  String? required_skills_one;
  String? required_skills_two;
  String? required_skills_three;
  String? required_skills_four;
  String? current_date;
  String? current_time;

  Jobs({
    this.id,
    this.job_id,
    this.job_image,
    this.job_name,
    this.company_name,
    required this.salary,
    required this.job_description,
    required this.required_skills_one,
    this.required_skills_two,
    this.required_skills_three,
    this.required_skills_four,
    this.current_date,
    this.current_time,
  });

  Jobs.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.job_id = map['job_id'];
    this.job_image = map['job_image'];
    this.job_name = map['job_name'];
    this.company_name = map['company_name'];
    this.salary = map['salary'];
    this.job_description = map['job_description'];
    this.required_skills_one = map['required_skills_one '];
    this.required_skills_two = map['required_skills_two '];
    this.required_skills_three = map['required_skills_three '];
    this.required_skills_four = map['required_skills_four '];
    this.current_date = map['current_date '];
    this.current_time = map['current_time '];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id;
    map['job_id'] = this.job_id;
    map['job_image'] = this.job_image;
    map['job_name'] = this.job_name;
    map['company_name'] = this.company_name;
    map['salary'] = this.salary;
    map['job_description'] = this.job_description;
    map['required_skills_one '] = this.required_skills_one;
    map['required_skills_two '] = this.required_skills_two;
    map['required_skills_three '] = this.required_skills_three;
    map['required_skills_four '] = this.required_skills_four;
    map['current_date '] = this.current_date;
    map['current_time '] = this.current_time;
    return map;
  }
}
