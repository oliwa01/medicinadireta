import 'package:flutter/material.dart';
import 'package:medicinadireta/screens/agendapaciente.dart';
import 'package:medicinadireta/screens/agendavazia.dart';
import 'package:medicinadireta/screens/prontuaro_screen.dart';
import 'package:medicinadireta/services/apimodel.dart';
import 'package:medicinadireta/services/networking.dart';
import 'package:medicinadireta/utilities/urisapi.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PacienteScreen extends StatefulWidget {
  PacienteScreen(this.tokenData, this.dataPaciente);
  var tokenData;
  var dataPaciente;
  @override
  _PacienteScreenState createState() => _PacienteScreenState();
}

class _PacienteScreenState extends State<PacienteScreen> {
  bool _isInAsyncCall = true;
  ApiModel apiModel = ApiModel();
  String chave = '';
  String duracao = '';
  void updateUI(dynamic apiData) {
    setState(() {
      chave = apiData['chave'];
      duracao = apiData['duracao'];
    });
  }

  List<dynamic> pacList = [];

  void geraListaPaciente(paciente) {
    for (var pac in paciente['value']) {
      pacList.add([
        pac['id'],
        pac['prontuario'],
        pac['nome'],
        pac['sobreNome'],
        pac['idade'],
        pac['cpf'],
        pac['rg'],
        pac['telefonePrincipal'],
        pac['email'],
        pac['convenioId'],
        pac['sexo'],
      ]);
    }
    ;
  }

  void getAgenda(pacienteId) async {
    ApiModel weathermodel = ApiModel();
    var tokenData = await weathermodel.getToken();

    NetworkHelper networkKelper = NetworkHelper(urlAgenda);
    var agendaData =
        await networkKelper.getAgendaFilter(tokenData['chave'], pacienteId);

    if (agendaData['value'].isEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AgendaVazia('Agenda Vazia');
      }));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AgendaPaciente(tokenData, agendaData);
      }));
    }
  }

  void getProntuario(pacienteId) async {
    Uri pacienteEvolucaoPaciente2 = Uri.https('api.medicinadireta.com.br',
        '/odata/PacienteEvolucao/Paciente(pacienteId=${pacienteId})');
    ApiModel weathermodel = ApiModel();
    var tokenData = await weathermodel.getToken();

    NetworkHelper networkKelper = NetworkHelper(pacienteEvolucaoPaciente2);
    var prontuario =
        await networkKelper.getProntuarioFilter(tokenData['chave'], pacienteId);

    if (prontuario['value'].isEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AgendaVazia('Prontuario');
      }));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ProntuarioPaciente(tokenData, prontuario);
      }));
    }
  }

  ajustaTelefone(telefone) {
    if ((telefone == null) || (telefone.isEmpty)) {
      telefone = '(00) 0000-0000';
    }

    return telefone;
  }

  calculaSizeFont(len) {
    if ('${len}'.length > 20) {
      return 10.0;
    }
    ;
    if ('${len}'.length > 15) {
      return 12.0;
    }
    ;
    if ('${len}'.length > 10) {
      return 15.0;
    }
    ;
    if ('${len}'.length > 8) {
      return 20.0;
    }
    ;
    return 25.0;
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      updateUI(widget.tokenData);
      geraListaPaciente(widget.dataPaciente);
    });
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = pacList.length;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.asset('assets/images/logo.png'),
        title: Text(
          "PACIENTES",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        actions: [
          Icon(Icons.sort_by_alpha, color: Colors.black),
          SizedBox(width: 20),
          Icon(Icons.sort_outlined, color: Colors.black),
          SizedBox(width: 20)
        ],
      ),
      body: itemCount > 0
          ? ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: itemCount,
              itemBuilder: (BuildContext, int index) {
                return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        getAgenda(pacList[index][0].toString());
                      },
                      child: Card(
                          color: Colors.grey[800],
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Container(
                                          width: 45.0,
                                          height: 45.0,
                                          decoration: new BoxDecoration(
                                              color: Colors.white12,
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: AssetImage(
                                                      'assets/images/${pacList[index][0]}.jpg')))),
                                      Text(pacList[index][0].toString(),
                                          style: TextStyle(fontSize: 12)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(pacList[index][2].toString(),
                                                style: TextStyle(
                                                    fontSize: calculaSizeFont(
                                                        pacList[index][2]))),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                            pacList[index][4].toString(),
                                            style: TextStyle(fontSize: 6)),
                                      ),
                                      SizedBox(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.phone,
                                                color: Colors.blue, size: 15),
                                            Text('  '),
                                            Text(
                                                ajustaTelefone(
                                                    pacList[index][7]),
                                                style: TextStyle(fontSize: 18)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        child: Text(
                                            pacList[index][8].toString(),
                                            style: TextStyle(fontSize: 8)),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextButton(
                                    onPressed: () {
                                      getProntuario(
                                          pacList[index][0].toString());
                                    },
                                    child: Icon(Icons.filter),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextButton(
                                    onPressed: () {
                                      getAgenda(pacList[index][0].toString());
                                    },
                                    child: Icon(Icons.calendar_today_sharp),
                                  ),
                                )
                              ]))),
                    ));
              })
          : ModalProgressHUD(
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
    );
  }
}
