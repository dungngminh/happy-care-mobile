import 'package:get/get.dart';
import 'package:happy_care/data/services/my_cloudinary_service.dart';

class ImageController extends GetxController {
  late final MyCloudinaryService myCloudinaryService;

  @override
  void onInit() {
    super.onInit();
    myCloudinaryService = MyCloudinaryService();
  }
}
