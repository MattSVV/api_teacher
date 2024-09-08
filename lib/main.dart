import 'package:flutter/material.dart';
import 'teacher.dart';
import 'api_servise.dart'; // Importa la clase ApiService

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TeacherListScreen(),
    );
  }
}

class TeacherListScreen extends StatefulWidget {
  @override
  _TeacherListScreenState createState() => _TeacherListScreenState();
}

class _TeacherListScreenState extends State<TeacherListScreen> {
  final ApiService apiService = ApiService();
  late Future<List<dynamic>> teachers;

  @override
  void initState() {
    super.initState();
    teachers = apiService.fetchTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teachers List'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: teachers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No teachers found'));
          } else {
            final List<dynamic> teachers = snapshot.data!;
            return ListView.builder(
              itemCount: teachers.length,
              itemBuilder: (context, index) {
                final teacher = teachers[index];
                return ListTile(
                  title: Text(teacher.lastname),
                  subtitle: Text('ID: ${teacher.idTeacher}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
