import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);

  final Uri url;

  Future<Map> postData() async {
    Map jsonBody = {"Login": "1234UF", "Senha": "112233UF4"};
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    http.Response response =
        await http.post(url, headers: headers, body: jsonEncode(jsonBody));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
    return jsonDecode('');
  }

  Future<Map> getAgendaFilter(chave, pacienteid) async {
    Map<String, String> headers = {
      'Accept-Encoding': 'gzip, deflate, br',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'pacienteId': '${pacienteid}',
      'Authorization': 'Bearer $chave',
    };
    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
    return jsonDecode('');
  }

  Future<Map> getProntuarioFilter(chave, pacienteid) async {
    Map<String, String> headers = {
      'Accept-Encoding': 'gzip, deflate, br',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'pacienteId': '${pacienteid}',
      'Authorization': 'Bearer $chave',
    };
    http.Response response = await http.get(url, headers: headers);
    print('Prontuario = ${response.statusCode}');
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
    return jsonDecode('');
  }

  Future<Map> getApiToken(chave) async {
    Map<String, String> headers = {
      'Accept-Encoding': 'gzip, deflate, br',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $chave',
    };

    http.Response response2 = await http.get(url, headers: headers);

    if (response2.statusCode == 200) {
      String data2 = response2.body;

      return jsonDecode(data2);
    }
    return jsonDecode('');
  }
}
