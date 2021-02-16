import 'package:http/http.dart' as Http;
import 'package:charoenkrung_app/config/config.dart';
class ImageService {
  static Future<bool> upload(String path) async {
    var request = Http.MultipartRequest('POST', Uri.parse('${Config.IMAGE}/upload'));
    request.files.add(await Http.MultipartFile.fromPath('file', path));
    var res = await request.send();
    if(res.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }
}