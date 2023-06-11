import 'package:http/http.dart' as http;

class Requests {

  static String url = 'http://localhost:8000/api/';

  static put(String element, Object body){
    return http.put(Uri.parse(url + element),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body
    );
  }

  static get(String element){
    return http.get(Uri.parse(url + element));
  }

  static delete(String element){
    return http.delete(Uri.parse(url + element));
  }
}