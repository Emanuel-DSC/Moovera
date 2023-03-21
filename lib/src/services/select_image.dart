import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<CroppedFile?> getImage() async {
  // pick image
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //crop image
  CroppedFile? croppedImage =
      await ImageCropper().cropImage(sourcePath: image!.path, aspectRatio: const CropAspectRatio(ratioX: 5, ratioY: 4));
  return croppedImage;
}

