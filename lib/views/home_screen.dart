import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/student_provider.dart';
import '../models/student_model.dart';
import 'add_student_screen.dart';
import 'edit_student_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<StudentProvider>(
        context,
        listen: false,
      ).fetchStudents();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider =
    Provider.of<StudentProvider>(context);

    return Scaffold(
      backgroundColor:
      const Color(0xffF5F6FA),

      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Home Screen",
        ),

        actions: [
          IconButton(
            icon:
            const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                StudentSearchDelegate(
                  provider.students,
                ),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(15),

        child: Column(
          children: [

            /// DASHBOARD

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

              child: Column(
                children: [

                  const Text(
                    "Total Students",
                    style: TextStyle(
                      color:
                      Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    provider.students.length
                        .toString(),

                    style:
                    const TextStyle(
                      color:
                      Colors.white,
                      fontSize: 42,
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

            Expanded(
              child: provider
                  .students.isEmpty

                  ? Center(
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .center,

                  children: const [

                    Icon(
                      Icons.school,
                      size: 90,
                      color:
                      Colors.grey,
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    Text(
                      "No Students Added Yet",
                      style:
                      TextStyle(
                        fontSize:
                        18,
                        color: Colors
                            .grey,
                      ),
                    ),
                  ],
                ),
              )

                  : ListView.builder(
                itemCount:
                provider
                    .students
                    .length,

                itemBuilder:
                    (context,
                    index) {

                  final student =
                  provider
                      .students[
                  index];

                  return Card(
                    elevation: 8,

                    margin:
                    const EdgeInsets
                        .only(
                      bottom: 12,
                    ),

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius
                          .circular(
                        20,
                      ),
                    ),

                    child:
                    ListTile(

                      contentPadding:
                      const EdgeInsets
                          .all(
                        15,
                      ),

                      leading:
                      CircleAvatar(
                        radius:
                        28,

                        backgroundColor:
                        Colors
                            .deepPurple,

                        child:
                        Text(
                          student.name
                              .isNotEmpty
                              ? student
                              .name[
                          0]
                              .toUpperCase()
                              : "?",

                          style:
                          const TextStyle(
                            color:
                            Colors
                                .white,
                            fontSize:
                            20,
                          ),
                        ),
                      ),

                      title: Text(
                        student.name,

                        style:
                        const TextStyle(
                          fontWeight:
                          FontWeight
                              .bold,
                        ),
                      ),

                      subtitle:
                      Padding(
                        padding:
                        const EdgeInsets
                            .only(
                          top: 5,
                        ),

                        child:
                        Text(
                          "${student.department}\n${student.email}",
                        ),
                      ),

                      trailing:
                      Row(
                        mainAxisSize:
                        MainAxisSize
                            .min,

                        children: [

                          IconButton(
                            icon:
                            const Icon(
                              Icons
                                  .edit,
                              color:
                              Colors.green,
                            ),

                            onPressed:
                                () {
                              Navigator
                                  .push(
                                context,

                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                      EditStudentScreen(
                                        student:
                                        student,
                                      ),
                                ),
                              );
                            },
                          ),

                          IconButton(
                            icon:
                            const Icon(
                              Icons
                                  .delete,
                              color:
                              Colors.red,
                            ),

                            onPressed:
                                () {

                              showDialog(
                                context:
                                context,

                                builder:
                                    (_) {

                                  return AlertDialog(
                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          15),
                                    ),

                                    title:
                                    const Text(
                                      "Delete Student",
                                    ),

                                    content:
                                    const Text(
                                      "Are you sure you want to delete this student?",
                                    ),

                                    actions: [

                                      TextButton(
                                        onPressed:
                                            () {
                                          Navigator.pop(
                                              context);
                                        },

                                        child:
                                        const Text(
                                          "Cancel",
                                        ),
                                      ),

                                      ElevatedButton(
                                        onPressed:
                                            () {

                                          provider.deleteStudent(
                                            student.id!,
                                          );

                                          Navigator.pop(
                                              context);
                                        },

                                        child:
                                        const Text(
                                          "Delete",
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton:
      FloatingActionButton.extended(
        backgroundColor:
        Colors.deepPurple,

        icon:
        const Icon(Icons.add,color: Colors.white,),

        label:
        const Text(
          "Add Student",
          style: TextStyle(color: Colors.white),
        ),

        onPressed: () {

          Navigator.push(
            context,

            MaterialPageRoute(
              builder: (_) =>
              const AddStudentScreen(),
            ),
          );
        },
      ),
    );
  }
}

/// SEARCH

class StudentSearchDelegate extends SearchDelegate {

  final List<Student> students;

  StudentSearchDelegate(this.students);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    // Search open hote hi kuch show nahi hoga

    if (query.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.search,
              size: 80,
              color: Colors.grey,
            ),

            SizedBox(height: 10),

            Text(
              "Search Student By Name",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    final results = students.where(
          (student) => student.name
          .toLowerCase()
          .contains(query.toLowerCase()),
    ).toList();

    if (results.isEmpty) {
      return const Center(
        child: Text(
          "No Student Found",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {

        final student = results[index];

        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),

          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(
                student.name[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            title: Text(student.name),

            subtitle: Text(
              "${student.department}\n${student.email}",
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    final results = students.where(
          (student) => student.name
          .toLowerCase()
          .contains(query.toLowerCase()),
    ).toList();

    if (results.isEmpty) {
      return const Center(
        child: Text(
          "No Student Found",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {

        final student = results[index];

        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),

          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child: Text(
                student.name[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            title: Text(student.name),

            subtitle: Text(
              "${student.department}\n${student.email}",
            ),
          ),
        );
      },
    );
  }
}