class Student {
  int? id;
  String name;
  String department;
  String email;

  Student({
    this.id,
    required this.name,
    required this.department,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'email': email,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      department: map['department'],
      email: map['email'],
    );
  }
}