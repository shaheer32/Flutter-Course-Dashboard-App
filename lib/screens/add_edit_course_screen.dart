import 'package:flutter/material.dart';

import '../models/course_model.dart';

import '../services/api_service.dart';

class AddEditCourseScreen
    extends StatefulWidget {

  final CourseModel? course;

  const AddEditCourseScreen({
    super.key,
    this.course,
  });

  @override
  State<AddEditCourseScreen> createState() =>
      _AddEditCourseScreenState();
}

class _AddEditCourseScreenState
    extends State<AddEditCourseScreen> {

  final _formKey =
      GlobalKey<FormState>();

  final titleController =
      TextEditingController();

  final bodyController =
      TextEditingController();

  bool isLoading = false;

  bool get isEdit =>
      widget.course != null;

  @override
  void initState() {

    super.initState();

    if (isEdit) {

      titleController.text =
          widget.course!.title;

      bodyController.text =
          widget.course!.body;
    }
  }

  Future<void> saveCourse() async {

    if (!_formKey.currentState!
        .validate()) {

      return;
    }

    try {

      setState(() {
        isLoading = true;
      });

      final course = CourseModel(

        id: widget.course?.id,

        title: titleController.text,

        body: bodyController.text,
      );

      if (isEdit) {

        await ApiService.updateCourse(
          course,
        );

      } else {

        await ApiService.addCourse(
          course,
        );
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content: Text(

            isEdit
                ? 'Course Updated'
                : 'Course Added',
          ),
        ),
      );

      Navigator.pop(
        context,
        true,
      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(e.toString()),
        ),
      );

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {

    titleController.dispose();

    bodyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(

          isEdit
              ? 'Edit Course'
              : 'Add Course',
        ),
      ),

      body: Padding(

        padding:
            const EdgeInsets.all(20),

        child: Form(

          key: _formKey,

          child: Column(

            children: [

              TextFormField(

                controller:
                    titleController,

                decoration:
                    const InputDecoration(

                  labelText:
                      'Course Title',

                  border:
                      OutlineInputBorder(),
                ),

                validator: (value) {

                  if (value == null ||
                      value.isEmpty) {

                    return 'Enter title';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(

                controller:
                    bodyController,

                maxLines: 5,

                decoration:
                    const InputDecoration(

                  labelText:
                      'Course Description',

                  border:
                      OutlineInputBorder(),
                ),

                validator: (value) {

                  if (value == null ||
                      value.isEmpty) {

                    return 'Enter description';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              SizedBox(

                width: double.infinity,
                height: 55,

                child: ElevatedButton(

                  onPressed:
                      isLoading
                          ? null
                          : saveCourse,

                  child: isLoading

                      ? const CircularProgressIndicator()

                      : Text(

                          isEdit
                              ? 'Update Course'
                              : 'Add Course',
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}