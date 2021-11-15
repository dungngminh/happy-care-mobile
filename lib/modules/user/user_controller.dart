import 'package:get/get.dart';
import 'package:happy_care/data/models/user.dart';
import 'package:happy_care/data/repositories/user_repository.dart';
import 'package:happy_care/routes/app_pages.dart';

enum Status { loading, done, error }

class UserController extends GetxController {
  var user = User.init().obs;
  final status = Status.loading.obs;
  final UserRepository? userRepository;

  UserController({this.userRepository});

  @override
  Future<void> onInit() async {
    super.onInit();
    await getUserInformation();
  }

  Future<void> signOut() async {
    await userRepository!.signOut();
    Get.offAllNamed(AppRoutes.rSignIn);
  }

  Future<void> getUserInformation() async {
    status(Status.loading);
    await userRepository!.getUserData().then((data) {
      user(data);
      status(Status.done);
    }).onError((error, stackTrace) {
      print("$error");
      status(Status.error);
    });
  }
}
