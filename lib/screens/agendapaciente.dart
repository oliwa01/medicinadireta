import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicinadireta/screens/detalheAgenda.dart';
import 'package:medicinadireta/services/apimodel.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AgendaPaciente extends StatefulWidget {
  AgendaPaciente(this.tokenData, this.dataAgenda);
  var tokenData;
  var dataAgenda;
  @override
  _AgendaPacienteState createState() => _AgendaPacienteState();
}

class _AgendaPacienteState extends State<AgendaPaciente> {
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

  List<dynamic> ids = [];

  void geraListaAgenda(agenda) {
    for (var tt in agenda['value']) {
      ids.add([
        tt['id'],
        tt['profissionalId'],
        tt['dataInicio'],
        tt['dataFim'],
        tt['horaInicio'],
        tt['horaFim'],
        tt['recorrencia'],
        tt['periodo'],
        tt['titulo'],
        tt['procedimento'],
        tt['pacienteId'],
        tt['pacienteFlagCadastro'],
        tt['observacoes'],
        tt['agendaStatusId'],
        tt['agendaSalaId'],
        tt['agendaConfigId'],
        tt['atendimentoStatusId'],
        tt['filaPosicao'],
        tt['emailEnviar'],
        tt['email'],
        tt['smsEnviar'],
        tt['smsTelefone'],
        tt['horaComparecimento'],
        tt['horaAtendimento'],
        tt['horaConcluido'],
        tt['online'],
        tt['usuarioCadastroId'],
        tt['dataCadastro'],
        tt['tipoAtendimento'],
        tt['usuarioAgendouId'],
        tt['dataUsuarioAgendou'],
        tt['dataInclusao'],
        tt['codigoExterno'],
        tt['agendaStatus']
      ]);
      print(ids);
    }
    ;
  }

  editaHora(hora) {
    if (hora == null) {
      hora = "0700";
    }
    String h1 = hora.replaceAll("PT", "");
    String h2 = h1.replaceAll("H", "");
    String h3 = h2.replaceAll("M", "");
    String h4 = "";
    int n1 = int.parse(h3);

    if (n1 < 25) {
      n1 = n1 * 100;
    }
    h4 = n1.toString();
    String h5 = ('${n1.toString()} hs');
    return h5;
  }

  editaDatas(data, hora) {
    String dataedit =
        ("${data.substring(8, 10)}-${data.substring(5, 7)}-${data.substring(0, 4)} - ${hora}");

    return dataedit;
  }

  ajustaTitulo(titulo) {
    if ((titulo.isEmpty) || (titulo == null)) {
      titulo = "Especialidade não especificada";
    }
    return titulo;
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      updateUI(widget.tokenData);
      geraListaAgenda(widget.dataAgenda);
    });
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = ids.length;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_sharp),
        ),
        title: Text(
          "CONSULTAS AGENDADAS",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: itemCount > 0
          ? ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: itemCount,
              itemBuilder: (BuildContext, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetalheAgenda(ids[index]);
                    }));
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                          color: Colors.grey[800],
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(Icons.date_range_rounded),
                                              Text(editaDatas(ids[index][2],
                                                  editaHora(ids[index][4])))
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(Icons.timer),
                                              Text(editaDatas(ids[index][3],
                                                  editaHora(ids[index][5])))
                                            ]),
                                        SizedBox(height: 30),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(Icons.health_and_safety),
                                              Text(ajustaTitulo(
                                                  ids[index][8].toString()))
                                            ]),
                                      ],
                                    ),
                                  ])))),
                );
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
