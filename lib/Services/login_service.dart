import 'package:http/http.dart' as http;

class Login {

  String formUrlEncoded(Map data) {
    var formArray = [];
    data.forEach((k, v) {
      formArray
          .add('${Uri.encodeQueryComponent(k)}=${Uri.encodeQueryComponent(v)}');
    });
    String form = formArray.join('&');
    return form;
  }

  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Cookie':
        'ARRAffinity=ec2b20e7a409657b5f63402c3d381f3af504babeb730535d16c672d2e77a3a47; ARRAffinitySameSite=ec2b20e7a409657b5f63402c3d381f3af504babeb730535d16c672d2e77a3a47'
  };

  Future<String> loginAsync(String usuario, String password) async {
    var request = http.Request(
        'POST', Uri.parse('https://tlaloc-dev.bdscorpnet.mx/token'));
    request.bodyFields = {
      'grant_type': 'password',
      'username': usuario,
      'password': password,
    };
    request.headers.addAll(headers);

    var response = await request.send();

    if (response.statusCode == 200) {
      print("Valor Streamed $response");
      final responseString = await response.stream.bytesToString();
      print("Valor en string $responseString");
      return responseString;
      //return valor;
    } else {
      print('Error llego aqui');
      throw Exception(("Imposible to make the request"));
    }
  }

  Future<bool> loginHttpAsync(String usuario, String password) async {
    Map<String, dynamic> formMap = {
      "grant_type": "password",
      "username": usuario,
      "password": password
    };

    final response =
        await http.post(Uri.parse('https://tlaloc-dev.bdscorpnet.mx/token'),
            //body: convert.jsonEncode(formMap),
            //body: formMap,
            body: formUrlEncoded(formMap));
            //headers: {"Content-Type": "application/x-www-form-urlencoded"});

            //encoding: convert.Encoding.getByName("UTF-8"));

    var valorEstatus = response.statusCode;
    var valorBody = response.body;
    print("Estatus code: $valorEstatus. Body: $valorBody");
    return true;
  }
}
