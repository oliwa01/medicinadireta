import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicinadireta/services/networking.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:truncate/truncate.dart';

import '../services/apimodel.dart';
import 'agendavazia.dart';
import 'medicamentospaciente.dart';

class ProntuarioPaciente extends StatefulWidget {
  ProntuarioPaciente(this.tokenData, this.dataAgenda);
  var tokenData;
  var dataAgenda;
  @override
  _ProntuarioPacienteState createState() => _ProntuarioPacienteState();
}

class _ProntuarioPacienteState extends State<ProntuarioPaciente> {
  bool _isInAsyncCall = true;
  ApiModel apiModel = ApiModel();
  String chave = '';
  String duracao = '';

  void getMedicamento(pacienteId) async {
    Uri pacientemedicamentos = Uri.https('api.medicinadireta.com.br',
        '/odata/pacienteevolucaomedicamento(${pacienteId})');
    ApiModel weathermodel = ApiModel();
    var tokenData = await weathermodel.getToken();

    NetworkHelper networkKelper = NetworkHelper(pacientemedicamentos);
    var medicamentos =
        await networkKelper.getProntuarioFilter(tokenData['chave'], pacienteId);

    if ("${medicamentos['value']}".length < 10) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AgendaVazia('Medicamento');
      }));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MedicamentosPaciente(tokenData, medicamentos);
      }));
    }
  }

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
        tt["id"],
        tt["pacienteId"],
        tt["unidade"],
        tt["contactado"],
        tt["dataInclusao"],
        tt["status"],
        tt["dataAgenda"],
        tt["horaAgenda"],
        tt["dataAgendaUTC"],
        tt["localAgenda"],
        tt["historico"],
        tt["tipoEditor"],
        tt["idOcorrencias"],
        tt["cid"],
        tt["cidDescricao"],
        tt["tuss"],
        tt["tussDescricao"],
        tt["logUsuario"],
        tt["logDataInclusao"],
        tt["logDataAtualizacao"],
        tt["dataUTC"],
        tt["dataSRV"],
        tt["dataLocal"],
        tt["editavel"],
        tt["ativado"],
      ]);
    }
    ;
  }

  editaDatas(data) {
    if ((data == null) || (data.isEmpty)) {
      return '00/00/0000';
    }
    String dataedit =
        ("${data.substring(8, 10)}-${data.substring(5, 7)}-${data.substring(0, 4)}");

    return dataedit;
  }

  checkString(text) {
    if (text == null) {
      return '';
    }
    return text;
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
          "PRONTUARIO",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: itemCount > 0
          ? ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: itemCount,
              itemBuilder: (BuildContext, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                          color: Colors.grey[800],
                          child: Expanded(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(editaDatas(ids[index][4]))
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(truncate(
                                              checkString(ids[index][10]), 35,
                                              omission: '...',
                                              position: TruncatePosition.end))
                                        ]),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    getMedicamento(ids[index][1]);
                                  },
                                  child: Icon(Icons.medication),
                                )
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
