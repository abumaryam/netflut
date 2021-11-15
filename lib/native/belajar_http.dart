import 'package:http/http.dart' as http;

void main() async {
  var url = Uri.parse('https://tg0rgz.deta.dev/');
  var response = await http.get(url);
  print(response.statusCode);
}
