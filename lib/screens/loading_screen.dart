import 'package:flutter/material.dart';
import 'package:medicinadireta/services/apimodel.dart';
import 'package:medicinadireta/services/networking.dart';
import 'package:medicinadireta/utilities/urisapi.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'paciente_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _isInAsyncCall = true;
  ApiModel weathermodel = ApiModel();
  @override
  void getChave() async {
    ApiModel weathermodel = ApiModel();
    var tokenData = await weathermodel.getToken();

    NetworkHelper networkKelper = NetworkHelper(paciente);

    var pacienteData = await networkKelper.getApiToken(tokenData['chave']);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PacienteScreen(tokenData, pacienteData);
    }));
  }

  void filtraPaciente() async {
    ApiModel weathermodel = ApiModel();
    var tokenData = await weathermodel.getToken();
    Uri urlFiltarAgenda = Uri.https(
        'api.medicinadireta.com.br', '/odata/Agenda', {'pacienteid': 123345});

    NetworkHelper networkKelper = NetworkHelper(paciente);

    var pacienteData = await networkKelper.getApiToken(tokenData['chave']);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PacienteScreen(tokenData, pacienteData);
    }));
  }

  void initState() {
    getChave();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ModalProgressHUD(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Container(),
          ),
        ),
        inAsyncCall: _isInAsyncCall,
        // demo of some additional parameters
        opacity: 0.15,
        progressIndicator: CircularProgressIndicator(),
      ),
    ));
  }
}
