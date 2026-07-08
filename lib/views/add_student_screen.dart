import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/student_model.dart';
import '../provider/student_provider.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() =>
      _AddStudentScreenState();
}

class _AddStudentScreenState
    extends State<AddStudentScreen> {

  final nameController =
  TextEditingController();

  final departmentController =
  TextEditingController();

  final emailController =
  TextEditingController();

  Future<void> saveStudent() async {

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

    final student = Student(
      name: nameController.text.trim(),
      department:
      departmentController.text.trim(),
      email:
      emailController.text.trim(),
    );

    await Provider.of<StudentProvider>(
      context,
      listen: false,
    ).addStudent(student);

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
          "Add Student",
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
                    Icons.person_add,
                    color:
                    Colors.white,
                    size: 70,
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Add New Student",
                    style: TextStyle(
                      color:
                      Colors.white,
                      fontSize: 22,
                      fontWeight:
                      FontWeight.bold,
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
                        saveStudent,

                        child:
                        const Text(
                          "Save Student",
                          style:
                          TextStyle(
                            color:
                            Colors
                                .white,
                            fontSize:
                            18,
                            fontWeight:
                            FontWeight
                                .bold,
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