import 'package:flutter/material.dart';

import '../models/course_model.dart';
import '../services/api_service.dart';
import '../controllers/auth_controller.dart';

import 'login_screen.dart';
import 'add_edit_course_screen.dart';
import 'detail_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String email;

  const DashboardScreen({
    super.key,
    required this.email,
  });

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  bool isLoading = false;
  String? errorMessage;
  List<CourseModel> courses = [];

  @override
  void initState() {
    super.initState();
    loadCourses();
  }

  // ---------------- GET COURSES ----------------
  Future<void> loadCourses() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final data =
          await ApiService.fetchCourses();

      setState(() {
        courses = data;
        isLoading = false;
      });

    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Failed to load courses";
      });
    }
  }

  // ---------------- DELETE COURSE ----------------
  Future<void> deleteCourse(int id) async {
    try {
      await ApiService.deleteCourse(id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Course Deleted"),
        ),
      );

      loadCourses();

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Delete Failed"),
        ),
      );
    }
  }

  // ---------------- DELETE CONFIRMATION ----------------
  void showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Course"),
          content: const Text(
            "Are you sure you want to delete this course?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                Navigator.pop(context);
                await deleteCourse(id);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  // ---------------- LOGOUT ----------------
  Future<void> logout() async {
    await AuthController.logout();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const LoginScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),

      // ---------------- ADD COURSE BUTTON ----------------
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const AddEditCourseScreen(),
            ),
          );

          if (result == true) {
            loadCourses();
          }
        },
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/300",
              ),
            ),

            const SizedBox(height: 10),

            Text(
              widget.email,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- BODY BUILDER ----------------
  Widget buildBody() {

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Text(
          errorMessage!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: loadCourses,
      child: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {

          final course = courses[index];

          return Card(
            child: ListTile(

              leading: CircleAvatar(
                child: Text(
                  course.id.toString(),
                ),
              ),

              title: Text(course.title),

              subtitle: Text(
                course.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              // ---------------- OPEN DETAIL ----------------
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailScreen(
                      subjectName:
                          course.title,
                    ),
                  ),
                );
              },

              // ---------------- EDIT COURSE ----------------
              onLongPress: () async {
                final result =
                    await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddEditCourseScreen(
                      course: course,
                    ),
                  ),
                );

                if (result == true) {
                  loadCourses();
                }
              },

              // ---------------- DELETE BUTTON ----------------
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  if (course.id == null) return;
                  showDeleteDialog(course.id!);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}