import 'package:http/http.dart' as http;

class Requests {

  static String url = 'https://das-web.shop/api/';

  static get(String element){
    return http.get(Uri.parse(url + element));
  }

  static delete(String element){
    return http.delete(Uri.parse(url + element));
  }
}