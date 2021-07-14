import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicinadireta/services/networking.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:truncate/truncate.dart';

import '../services/apimodel.dart';
import 'agendavazia.dart';

class MedicamentosPaciente extends StatefulWidget {
  MedicamentosPaciente(this.tokenData, this.dataAgenda);
  var tokenData;
  var dataAgenda;
  @override
  _MedicamentosPacienteState createState() => _MedicamentosPacienteState();
}

class _MedicamentosPacienteState extends State<MedicamentosPaciente> {
  bool _isInAsyncCall = true;
  ApiModel apiModel = ApiModel();
  String chave = '';
  String duracao = '';

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
        return AgendaVazia('Medicamentos');
      }));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MedicamentosPaciente(tokenData, prontuario);
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
        tt["dataUsoIni"],
        tt["dataUsoFim"],
        tt["medicamentoId"],
        tt["medicamentoDescricao"],
        tt["principioAtivo"],
        tt["posologia"],
        tt["statusUso"],
        tt["tipoInformacao"],
        tt["logDataInclusao"],
        tt["logDataAtualizacao"],
        tt["dataEvento"],
        tt["logUsuario"],
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
          "MEDICAMENTOS",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: itemCount > 0
          ? ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: itemCount,
              itemBuilder: (BuildContext, int index) {
                return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                        color: Colors.grey[800],
                        child: Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(editaDatas(
                                            ids[index][2].toString()))
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(ids[index][5].toString())
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(ids[index][6].toString())
                                      ]),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(truncate(
                                            checkString(ids[index][7]), 42,
                                            omission: '...',
                                            position: TruncatePosition.end))
                                      ]),
                                ],
                              ),
                            ]))));
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
