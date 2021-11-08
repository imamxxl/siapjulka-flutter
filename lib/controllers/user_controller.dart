import 'package:get/get.dart';
import 'package:siapjulka/models/user.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var items = List<User>.empty().obs;

  void getProfile() async {
    // var profile = await UserService.getProfile();
  }
}
