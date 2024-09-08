class Teacher {
  final int idTeacher;
  final String dni;
  final String lastname;
  final String name;
  final String subject;

  Teacher({
    required this.idTeacher,
    required this.dni,
    required this.lastname,
    this.name = '',
    this.subject = '',
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      idTeacher: json['id_teacher'] ?? 0,
      dni: json['dni'] ?? '',
      lastname: json['lastname'] ?? '',
      name: json['name'] ?? '',
      subject: json['subject'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_teacher': idTeacher,
      'dni': dni,
      'lastname': lastname,
      'name': name,
      'subject': subject,
    };
  }
}
