
import 'package:http/http.dart' as http;
import 'package:todo/services/global_services.dart';

class TodoServices 
{
  static Future add (String title, String userId) async {
     var data = {
      "title": title,
      "user_id": userId,
     };

     var url = Uri.parse("${baseURL}add_todo.php");
     http.Response response = await http.post(url, body: data);

     return response;
  }
 
  static Future view (String? query, String userId) async {
    var data = {};

    if(query != null){
      data = {
      "title": query,
      "user_id": userId
     };
    }else {

      data = {
      "user_id": userId
     };
    }

     var url = Uri.parse("${baseURL}show_todo.php");
     http.Response response = await http.post(url, body: data);

     return response;
  }

  static Future search (String? query, String userId) async {
     var data = {
      "title": query,
      "user_id": userId,
     };

     var url = Uri.parse("${baseURL}search_todo_list.php");
     http.Response response = await http.post(url, body: data);

     return response;
  }

  static Future update (String id, String title) async {
     Map data = {
      "id": id,
      "title": title,
     };

     var url = Uri.parse("${baseURL}update_todo.php");
     http.Response response = await http.post(url, headers: headers, body: data);

     return response;
  }

  static Future deleteList (String id) async {
     var data = {
      "id": id
     };

     var url = Uri.parse("${baseURL}delete_list.php");
     http.Response response = await http.post(url, body: data);

     return response;
  }

  static Future deleteMultipleLists (String id) async {
     var data = {
      "id": id
     };

     var url = Uri.parse("${baseURL}delete_multiple_lists.php");
     http.Response response = await http.post(url, body: data);

     return response;
  }
  
  static Future doneTodo (String id, String isDone) async {
     var data = {
      "id": id,
      "is_done": isDone
     };

     var url = Uri.parse("${baseURL}done_todo.php");
     http.Response response = await http.post(url, body: data);

     return response;
  }

}