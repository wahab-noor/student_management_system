import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/student_model.dart';

class StudentProvider extends ChangeNotifier {
  final DBHelper _dbHelper = DBHelper();

  List<Student> _students = [];

  List<Student> get students => _students;

  Future<void> fetchStudents() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps =
    await db.query('students');

    _students =
        maps.map((e) => Student.fromMap(e)).toList();

    notifyListeners();
  }

  Future<void> addStudent(Student student) async {
    final db = await _dbHelper.database;

    await db.insert(
      'students',
      student.toMap(),
    );

    await fetchStudents();
  }

  Future<void> deleteStudent(int id) async {
    final db = await _dbHelper.database;

    await db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );

    await fetchStudents();
  }

  Future<void> updateStudent(Student student) async {
    final db = await _dbHelper.database;

    await db.update(
      'students',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );

    await fetchStudents();
  }
}