import 'package:http/http.dart' as http;

class Requests {

  static String url = 'http://localhost:8000/api/';

  static get(String element){
    return http.get(Uri.parse(url + element));
  }

  static delete(String element){
    return http.delete(Uri.parse(url + element));
  }
}