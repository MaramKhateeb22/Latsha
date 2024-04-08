import 'package:image_picker/image_picker.dart';
import 'package:mopidati/widgets/message.dart';

pickImage(ImageSource source, context) async {
  ImagePicker _imagepicker = ImagePicker();
  XFile? _file = await _imagepicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  } else {
    message(context, 'No Image Selected');
    print('No Image Selected');
  }
}
