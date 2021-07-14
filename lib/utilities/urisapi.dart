Uri agendaAlterarStatus =
    Uri.https('api.medicinadireta.com.br', '/odata/Agenda/{key}/AlterarStatus');
Uri agendaCheckIn =
    Uri.https('api.medicinadireta.com.br', '/odata/Agenda/CheckIn');
Uri agendaConfig =
    Uri.https('api.medicinadireta.com.br', '/odata/AgendaConfig');
Uri agendaConfirmar =
    Uri.https('api.medicinadireta.com.br', '/odata/Agenda/Confirmar');
Uri agendaDesmarcar =
    Uri.https('api.medicinadireta.com.br', '/odata/Agenda/Desmarcar');
Uri agendaReagendamento =
    Uri.https('api.medicinadireta.com.br', '/odata/Agenda/{key}/Reagendamento');
Uri agendaSala = Uri.https('api.medicinadireta.com.br', '/odata/AgendaSala');
Uri cid = Uri.https('api.medicinadireta.com.br', '/odata/Cid');
Uri cidSubCategoria =
    Uri.https('api.medicinadireta.com.br', '/odata/CidSubCategoria');
Uri clinica = Uri.https('api.medicinadireta.com.br', '/odata/Clinica');
Uri clinicaObterFiliais =
    Uri.https('api.medicinadireta.com.br', '/odata/Clinica/ObterFiliais');
Uri convenio = Uri.https('api.medicinadireta.com.br', '/odata/Convenio');
Uri faturamento = Uri.https('api.medicinadireta.com.br', '/odata/Faturamento');
Uri faturamentoPaciente = Uri.https('api.medicinadireta.com.br',
    '/odata/Faturamento/Paciente(pacienteid={pacienteid})');
Uri medicamento = Uri.https('api.medicinadireta.com.br', '/odata/Medicamento');
Uri mensagem = Uri.https('api.medicinadireta.com.br', '/odata/Mensagem');
Uri mensagemHistoricoCorreio =
    Uri.https('api.medicinadireta.com.br', '/odata/Mensagem/HistoricoCorreio');
Uri mensagemHistoricoSms =
    Uri.https('api.medicinadireta.com.br', '/odata/Mensagem/HistoricoSms');
Uri mensagemInserirCorreioAgendamento = Uri.https(
    'api.medicinadireta.com.br', '/odata/Mensagem/InserirCorreioAgendamento');
Uri mensagemInserirSmsAgendamento = Uri.https(
    'api.medicinadireta.com.br', '/odata/Mensagem/InserirSmsAgendamento');
Uri mensagemInserirSmsIndividual = Uri.https(
    'api.medicinadireta.com.br', '/odata/Mensagem/InserirSmsIndividual');
Uri mensagemModeloEmail =
    Uri.https('api.medicinadireta.com.br', '/odata/Mensagem/ModeloEmail');
Uri mensagemModeloSms =
    Uri.https('api.medicinadireta.com.br', '/odata/Mensagem/ModeloSms');
Uri paciente = Uri.https('api.medicinadireta.com.br', '/odata/Paciente');
Uri pacienteEvolucao =
    Uri.https('api.medicinadireta.com.br', '/odata/PacienteEvolucao');
Uri pacienteEvolucaoAnexo = Uri.https(
    'api.medicinadireta.com.br', '/odata/PacienteEvolucaoAnexo({PacienteId})');
Uri pacienteEvolucaoAnexoBuscarAnexo = Uri.https('api.medicinadireta.com.br',
    '/odata/PacienteEvolucaoAnexo/BuscarAnexo(idAnexo={idAnexo})');
Uri pacienteEvolucaoMedicamento = Uri.https('api.medicinadireta.com.br',
    '/odata/PacienteEvolucaoMedicamento({pacienteId})');
Uri pacienteEvolucaoModelo =
    Uri.https('api.medicinadireta.com.br', '/odata/PacienteEvolucaoModelo');
Uri pacienteEvolucaoPaciente = Uri.https('api.medicinadireta.com.br',
    '/odata/PacienteEvolucao/Paciente(pacienteId={pacienteId})');
Uri pacienteProdutos =
    Uri.https('api.medicinadireta.com.br', '/odata/PacienteProdutos');
Uri pacienteTelefone = Uri.https(
    'api.medicinadireta.com.br', '/odata/PacienteTelefone({pacienteId})');
Uri pacienteTelefonePacienteId = Uri.https('api.medicinadireta.com.br',
    '/odata/PacienteTelefone/PacienteId(pacienteId={pacienteId})');
Uri seguranca = Uri.https('api.medicinadireta.com.br', '/odata/Seguranca');
Uri Servico = Uri.https('api.medicinadireta.com.br', '/odata/Servico');
Uri servico = Uri.https('api.medicinadireta.com.br', '/odata/Servico');
Uri ServicoCategoria =
    Uri.https('api.medicinadireta.com.br', '/odata/ServicoCategoria');
Uri token = Uri.https('api.medicinadireta.com.br', '/odata/Token');
Uri Usuario = Uri.https('api.medicinadireta.com.br', '/odata/Usuario');
Uri UsuarioObterProfissionais = Uri.https('api.medicinadireta.com.br',
    '/odata/Usuario/ObterProfissionais(ClinicaId={clinicaId})');
Uri agenda = Uri.https('api.medicinadireta.com.br', '/odata/Agenda({key})');
Uri urlAgenda = Uri.https('api.medicinadireta.com.br', '/odata/Agenda');
Uri urlAgendaSort = Uri.https(
    'api.medicinadireta.com.br', '/odata/Agenda/apis?sort=nome&direction=asc');
