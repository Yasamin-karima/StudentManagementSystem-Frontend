
import 'dart:async';
import 'package:project_front_end/classes/models.dart';
import 'dart:convert';
import 'dart:io';

class SocketMethods {

  static String response = '';
  static String userId = '' , _password = '', _name = '';
  static Socket? socket;
  static final SocketMethods _socketMethods = SocketMethods.internal();

  SocketMethods.internal();

  factory SocketMethods() {
    return _socketMethods;
  }


  static Future<String> initSocket(String command) async{
    var completer = Completer<String>();
    Socket.connect('192.168.8.175', 50050).then(
            (socket) {
          print('in _initSocket method and socket port is:');
          print(socket.port);
          socket.writeln(command);

          socket.listen((resp) {
            response = utf8.decode(resp).trim();
            completer.complete(response);
            // response = String.fromCharCodes(resp);
            // print('res is:$response');
          }).onDone(() {
            print('is done!!');
          });
        });
    return await completer.future;
  }

  static Future<String> studentLogin () async {
    String command = 'studentLogin*$userId*$_password*';
    Future<String> resp = initSocket(command);
    print('RESPONSE IN STUDENTLOGIN METHOD');
    return resp;
  }
  static Future<String> studentSignUp () async {
    String command = 'studentSignUp*$userId*$_password*$_name';
    Future<String> resp = initSocket(command);
    print('RESPONSE IN STUDENT_SIGNUP METHOD');
    return resp;
  }
  static Future<Student> getStudent() async {
    String command = 'getStudent*$userId';
    String resp = await initSocket(command);
    print('RESPONSE IN GET_STUDENT METHOD');
    print('THIS IS STRING RESP:::::');
    print(resp);
    return Student.fromJsonMap(jsonDecode(resp));
  }


  static Future<List<Course>> getCourses() async{
    String command = 'getCourse*$userId*';
    String resp = await initSocket(command);
    print('RESPONSE IN STUDENT_GET_COURSE METHOD');

    print('THIS IS STRING RESP:::::');
    print(resp);

    return _createTheCourseList(jsonDecode(resp));
  }
  static List<Course> _createTheCourseList(List<dynamic> list){
    List<Course> result = [];
    for (dynamic d in list){
      result.add(Course.fromJsonMap(d));
    }
    return result;
  }
  static Future<String> addCourse(String courseId) async  {
    String command = 'createCourse*$userId*$courseId';
    String resp = await initSocket(command);
    print('RESPONSE IN STUDENT_ADD_COURSE METHOD');

    print(resp);
    return resp;
  }


  static Future<List<Todo>> getTodo() async{
    String command = 'getTodo*$userId*';
    String resp = await initSocket(command);
    print('RESPONSE IN STUDENT_GET_TODO METHOD');

    print('THIS IS STRING RESP:::::');
    print(resp);

    return _createTodoList(jsonDecode(resp));
  }
  static List<Todo> _createTodoList(List<dynamic> list){
    List<Todo> result = [];
    // print(list);
    for (dynamic d in list){
      result.add(Todo.fromJsonMap(d));
    }
    // print(result);
    return result;
  }
  static Future<void> setTodoState(String title, bool newValue) async {
    String command = 'setTodoState*$userId*$title*$newValue';
    String resp = await initSocket(command);
    print('RESPONSE IN STUDENT_SET_TODO METHOD');

    print('THIS IS STRING RESP:::::');
    print(resp);
  }
  static Future<void> removeTodo(String title) async{
    String command = 'removeTodo*$userId*$title';
    String resp = await initSocket(command);
    print('RESPONSE IN STUDENT_SET_TODO METHOD');

    print('THIS IS STRING RESP:::::');
    print(resp);
  }
  static Future<void> addTodo(String title) async{
    String command = 'createTodo*$userId*$title';
    String resp = await initSocket(command);
    print('RESPONSE IN STUDENT_ADD_TODO METHOD');

    print('THIS IS STRING RESP:::::');
    print(resp);
  }


  static Future<List<Assignment>> getDoneAssigns(String sortFormat) async{
    String command = 'getDoneAssigns*$userId*$sortFormat';
    String resp = await initSocket(command);
    print('RESPONSE IN STUDENT_GET_DONE_ASS METHOD');

    print('THIS IS STRING RESP:::::');
    print(resp);

    return _createAssignList(jsonDecode(resp));
  }
  static Future<List<Assignment>> getUndoneAssigns(String sortFormat) async{
    String command = 'getUndoneAssigns*$userId*$sortFormat';
    String resp = await initSocket(command);
    print('RESPONSE IN STUDENT_GET_DONE_ASS METHOD');

    print('THIS IS STRING RESP:::::');
    print(resp);

    return _createAssignList(jsonDecode(resp));
  }
  static List<Assignment> _createAssignList(List<dynamic> list){
    List<Assignment> result = [];
    for (dynamic d in list){
      result.add(Assignment.fromJsonMap(d));
    }
    return result;
  }
  static Future<Assignment> studentBestAssignment() async {
    String command = 'getBestAssign*$userId';
    String resp = await initSocket(command);
    return Assignment.fromJsonMap(jsonDecode(resp));
  }
  static Future<Assignment> studentWorstAssignment() async {
    String command = 'getWorstAssign*$userId';
    String resp = await initSocket(command);
    return Assignment.fromJsonMap(jsonDecode(resp));
  }


  static Future<void> changePassword (String newPass) async {
    print("&&&&&&&PASS&&&&&&&&&");
    print(newPass);
    String command = 'changePassword*$userId*$newPass*';
    String resp = await initSocket(command);
    print('RESPONSE IN STUDENT_CHANGE_PASS METHOD');
    print(resp);
  }
  static Future<void> deleteAccount () async {
    String command = 'deleteAccount*$userId';
    String resp = await initSocket(command);
    print('RESPONSE IN STUDENT_deleteAccount METHOD');
    print(resp);
  }

  void setUserId(String value){
    userId = value;
    print('@@@@@@@@@@@@@@@@@@ ID' + userId + '@@@@@@@@@@@@@@@@@@');
  }
  void setPassword(String value){
    _password = value;
    print('@@@@@@@@@@@@@@@@@@ PASS' + _password + '@@@@@@@@@@@@@@@@@@');
  }
  void setName(String value){
    _name = value;
    print('@@@@@@@@@@@@@@@@@@ NAME' + _name + '@@@@@@@@@@@@@@@@@@');
  }


}

