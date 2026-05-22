import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/course_model.dart';

class ApiService {

  static const String baseUrl =
      'https://jsonplaceholder.typicode.com/posts';

  // GET Courses
  static Future<List<CourseModel>>
      fetchCourses() async {

    final response =
        await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {

      List data = jsonDecode(response.body);

      return data
          .map(
            (json) =>
                CourseModel.fromJson(json),
          )
          .toList();

    } else {

      throw Exception(
        'Failed to load courses',
      );
    }
  }

  // POST Course
  static Future<CourseModel> addCourse(
    CourseModel course,
  ) async {

    final response = await http.post(

      Uri.parse(baseUrl),

      headers: {
        'Content-Type':
            'application/json',
      },

      body: jsonEncode(
        course.toJson(),
      ),
    );

    if (response.statusCode == 201) {

      return CourseModel.fromJson(
        jsonDecode(response.body),
      );

    } else {

      throw Exception(
        'Failed to add course',
      );
    }
  }

  // PUT Course
  static Future<CourseModel> updateCourse(
    CourseModel course,
  ) async {

    final response = await http.put(

      Uri.parse(
        '$baseUrl/${course.id}',
      ),

      headers: {
        'Content-Type':
            'application/json',
      },

      body: jsonEncode(
        course.toJson(),
      ),
    );

    if (response.statusCode == 200) {

      return CourseModel.fromJson(
        jsonDecode(response.body),
      );

    } else {

      throw Exception(
        'Failed to update course',
      );
    }
  }

  // DELETE Course
static Future<void> deleteCourse(int id) async {

  final response = await http.delete(
    Uri.parse('$baseUrl/$id'),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to delete course');
  }
}

}

