import 'package:image_picker/image_picker.dart';

Future<String> pickImage({ImagePicker picker}) async {
  final file = await picker.getImage(source: ImageSource.gallery);
  if (file != null) {
    return file.path;
  }
  return "";
}
