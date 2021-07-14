import 'networking.dart';

class ApiModel {
  Future<dynamic> getToken() async {
    Uri urlc = Uri.https('api.medicinadireta.com.br', '/odata/token');
    NetworkHelper networkKelper = NetworkHelper(urlc);
    var apiData = await networkKelper.postData();
    return apiData;
  }
}
