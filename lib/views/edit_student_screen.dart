import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/student_model.dart';
import '../provider/student_provider.dart';

class EditStudentScreen extends StatefulWidget {
  final Student student;

  const EditStudentScreen({
    super.key,
    required this.student,
  });

  @override
  State<EditStudentScreen> createState() =>
      _EditStudentScreenState();
}

class _EditStudentScreenState
    extends State<EditStudentScreen> {

  late TextEditingController nameController;
  late TextEditingController departmentController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.student.name,
    );

    departmentController =
        TextEditingController(
          text: widget.student.department,
        );

    emailController = TextEditingController(
      text: widget.student.email,
    );
  }

  Future<void> updateStudent() async {

    if (nameController.text.trim().isEmpty ||
        departmentController.text
            .trim()
            .isEmpty ||
        emailController.text
            .trim()
            .isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill all fields",
          ),
        ),
      );

      return;
    }

    final updatedStudent = Student(
      id: widget.student.id,
      name: nameController.text.trim(),
      department:
      departmentController.text.trim(),
      email:
      emailController.text.trim(),
    );

    await Provider.of<StudentProvider>(
      context,
      listen: false,
    ).updateStudent(updatedStudent);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    departmentController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
      const Color(0xffF5F6FA),

      appBar: AppBar(
        title: const Text(
          "Update Student",
        ),
      ),

      body: SingleChildScrollView(
        padding:
        const EdgeInsets.all(20),

        child: Column(
          children: [

            Container(
              width: double.infinity,
              padding:
              const EdgeInsets.all(20),

              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(
                  20,
                ),

                gradient:
                const LinearGradient(
                  colors: [
                    Color(0xff6A11CB),
                    Color(0xff2575FC),
                  ],
                ),
              ),

              child: const Column(
                children: [

                  Icon(
                    Icons.edit_note,
                    color:
                    Colors.white,
                    size: 70,
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Update Student",
                    style: TextStyle(
                      color:
                      Colors.white,
                      fontSize: 22,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Text(
                    "Modify Student Information",
                    style: TextStyle(
                      color:
                      Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Card(
              elevation: 8,

              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(
                  20,
                ),
              ),

              child: Padding(
                padding:
                const EdgeInsets.all(
                  20,
                ),

                child: Column(
                  children: [

                    TextField(
                      controller:
                      nameController,

                      decoration:
                      InputDecoration(
                        labelText:
                        "Student Name",

                        prefixIcon:
                        const Icon(
                          Icons.person,
                        ),

                        border:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    TextField(
                      controller:
                      departmentController,

                      decoration:
                      InputDecoration(
                        labelText:
                        "Department",

                        prefixIcon:
                        const Icon(
                          Icons.school,
                        ),

                        border:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    TextField(
                      controller:
                      emailController,

                      keyboardType:
                      TextInputType
                          .emailAddress,

                      decoration:
                      InputDecoration(
                        labelText:
                        "Email",

                        prefixIcon:
                        const Icon(
                          Icons.email,
                        ),

                        border:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    SizedBox(
                      width:
                      double.infinity,

                      height: 55,

                      child:
                      ElevatedButton(
                        style:
                        ElevatedButton
                            .styleFrom(
                          backgroundColor:
                          Colors
                              .deepPurple,

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius
                                .circular(
                              15,
                            ),
                          ),
                        ),

                        onPressed:
                        updateStudent,

                        child:
                        const Text(
                          "Update Student",
                          style:
                          TextStyle(
                            color:
                            Colors.white,
                            fontSize:
                            18,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}