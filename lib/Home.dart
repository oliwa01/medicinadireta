import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Uri token = Uri.https('api.medicinadireta.com.br', '/odata/token',
      {"Login": "1234UF", "Senha": "112233UF4"});
  Future getToken() async {
    Response tokenapi = get(token) as Response;
    print(tokenapi);
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
