
import 'dart:core';
import 'package:shamsi_date/shamsi_date.dart';


class Course {
  String name; //مدار الکتریکی
  String id; //4022EC
  int unit;
  Teacher teacher;
  String examDate;
  List times;

  Course(this.name, this.id, this.unit, this.teacher, this.examDate, this.times); //3
  // Date examDate;// use java class
  // ArrayList<Assignment> assignments = new ArrayList<>();
  // ArrayList<Student> students = new ArrayList<>();
  // ArrayList<Term> terms = new ArrayList<>();

  factory Course.fromJsonMap(Map<String, dynamic> map){
    return Course(map['name'], map['id'], map['unit'],
        Teacher.fromJsonMap(map['teacher']), map['examDate'], map['courseTimes']);
  }

  Jalali getJalaliDate(){
    var split = examDate.split("-");
    DateTime d = DateTime(int.parse(split[0]), int.parse(split[1]), int.parse(split[2]));
    return Jalali.fromDateTime(d);
  }


  // public String getId() {
  //   return id;
  // }

  /*public Teacher getTeacher() {
    return teacher;
  }*/
  //
  // public String getName() {
  //   return name;
  // }
  // public int getUnit() {
  //   return unit;
  // }
  // public int getNoOfStudents() {
  //   return students.size();
  // }
  // public int getNoOfAssignments() {
  //   return assignments.size();
  // }
  // public String getExamDate() {
  //   return examDate.toString();
  // }


}

class Todo {
  String title;
  bool isDone;


  Todo(this.title, this.isDone);

  factory Todo.fromJsonMap(Map<String, dynamic> map){
    return Todo(map['title'], map['isDone']);
  }

}

class Teacher {
  String name;
  Teacher(this.name);
  factory Teacher.fromJsonMap(Map<String, dynamic> map){
    return Teacher(map['name']);
  }
}

class Assignment{
  Course? course;
  bool? isDone;
  String title;
  String teacherDescription;
  late String studentDescription;
  String deadline;
  DateTime? estimatedTime;
  double score;

  Assignment(this.title, this.course, this.teacherDescription, this.deadline, this.score, this.isDone);

  factory Assignment.fromJsonMap(Map<String, dynamic> map){
    return Assignment(map['title'], Course.fromJsonMap(map['course']),
        map['description'], map['deadline'], map['score'],
        (map['score'] == 0) ? false : true);
  }

  Jalali getJalaliDeadline(){
    var split = deadline.split("-");
    DateTime d = DateTime(int.parse(split[0]), int.parse(split[1]), int.parse(split[2]));
    return Jalali.fromDateTime(d);
  }
}

class Student{
  String name;
  String averageScore;
  DateTime? dateOfBirth;
  String id;
  String password;
  String totalUnits;

  Student(this.name, this.averageScore, this.id, this.password, this.totalUnits, this.dateOfBirth);

  factory Student.fromJsonMap(Map<String, dynamic> map){
    return Student(map['name'], map['average'].toString(), map['id'].toString(), map['password'],
        map['totalUnits'].toString(),
    map.keys.contains('birth') ? map['birth'] : null);
  }
}
