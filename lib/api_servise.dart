import 'dart:convert';
import 'package:http/http.dart' as http;
import 'teacher.dart'; // Importa tu modelo Teacher

class ApiService {
  final String baseUrl =
      'http://localhost:8080/api/teachers'; // Cambia a la URL de tu API

  // Obtener todos los profesores
  Future<List<Teacher>> fetchTeachers() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      print(response.body);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Teacher.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load teachers');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load teachers: $e');
    }
  }

  // Obtener un profesor por ID
  Future<Teacher> fetchTeacherById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Teacher.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load teacher');
    }
  }

  // Crear un nuevo profesor
  Future<void> createTeacher(Teacher teacher) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(teacher.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create teacher');
    }
  }

  // Eliminar un profesor por ID
  Future<void> deleteTeacher(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete teacher');
    }
  }
}
