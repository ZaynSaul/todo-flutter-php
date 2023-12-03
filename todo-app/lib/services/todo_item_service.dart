import 'package:http/http.dart' as http;
import 'package:todo/services/global_services.dart';

class TodoItemServices {
  
  static Future add(String title, String description, String todoId) async {
    var data = {
      "title": title,
      "description": description,
      "todo_id": todoId,
    };

    var url = Uri.parse("${baseURL}add_todo_item.php");
    http.Response response = await http.post(url, body: data);

    return response;
  }

  static Future view(String todoId) async {
    var data = {"todo_id": todoId};

    var url = Uri.parse("${baseURL}show_todo_item.php");
    http.Response response = await http.post(url, body: data);

    return response;
  }

  static Future update(
      String id, String title, String description, String todoId) async {
    var data = {
      "id": id,
      "title": title,
      "description": description,
      "todo_id": todoId
    };

    var url = Uri.parse("${baseURL}update_todo_item.php");
    http.Response response = await http.post(url, body: data);

    return response;
  }

  static Future delete(String id) async {
    var data = {"id": id};

    var url = Uri.parse("${baseURL}delete_todo_item.php");
    http.Response response = await http.post(url, body: data);

    return response;
  }

  static Future doneTodo(String id, String isDone) async {
    var data = {"id": id, "is_done": isDone};

    var url = Uri.parse("${baseURL}done_todo_item.php");
    http.Response response = await http.post(url, body: data);

    return response;
  }

  static Future countTodoItem(String todoId) async {
    var data = {
      "todo_id": todoId
    };

    var url = Uri.parse("${baseURL}count_todo_item.php");
    http.Response response = await http.post(url, body: data);

    return response;
  }
}
