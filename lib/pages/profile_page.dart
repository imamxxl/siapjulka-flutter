import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siapjulka/constant/pallete_color.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapjulka/controllers/user_controller.dart';

import 'package:siapjulka/models/user.dart';
import 'package:siapjulka/network/domain.dart';
import 'package:siapjulka/routes/name_route.dart';
import 'package:siapjulka/services/user_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showPassword = false;
  int id = 0;
  late Future<User> futureUser;

  UserController userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    futureUser = UserService().getUser();
  }

  Widget buildTextField(
      IconData iconData,
      String labelText,
      String placeholder,
      bool isPasswordTextField,
      TextEditingController controller,
      bool enabled) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          // wrap your Column in Expanded
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              iconData,
              color: Pallete.primaryColor,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          // wrap your Column in Expanded
          child: Padding(
            padding: const EdgeInsets.only(bottom: 35.0),
            child: TextField(
              controller: controller,
              enabled: enabled,
              obscureText: isPasswordTextField ? showPassword : false,
              decoration: InputDecoration(
                suffixIcon: isPasswordTextField
                    ? IconButton(
                        icon: Icon(
                          (showPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.only(bottom: 3),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: placeholder,
                labelText: labelText,
                hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pullRefresh() async {
    userController.get();
    futureUser = UserService().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: _pullRefresh,
          child: Container(
            padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                Domain().imageUrl +
                                    "/avatar/${userController.dataUser.value.avatar}",
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Pallete.primaryColor,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  buildTextField(
                      Icons.account_circle_outlined,
                      "NIM",
                      '${userController.dataUser.value.nim}',
                      false,
                      TextEditingController(),
                      false),
                  buildTextField(
                      Icons.badge_outlined,
                      "Nama",
                      '${userController.dataUser.value.nama}',
                      false,
                      TextEditingController(),
                      false),
                  buildTextField(
                      Icons.article_outlined,
                      "Gender",
                      '${userController.dataUser.value.jk}',
                      false,
                      TextEditingController(),
                      false),
                  buildTextField(
                      Icons.school_outlined,
                      "Jurusan",
                      '${userController.dataUser.value.namaJurusan}',
                      false,
                      TextEditingController(),
                      false),
                  buildTextField(Icons.lock_outline_rounded, "Password",
                      "******", true, userController.passwordController, true),
                  buildTextField(
                    Icons.app_settings_alt_outlined,
                    "ID Perangkat",
                    (userController.dataUser.value.imei == null
                        ? 'Perangkat belum terdaftar'
                        : userController.dataUser.value.imei!),
                    false,
                    TextEditingController(),
                    false,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Pallete.successColor,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Pallete.successColor[200],
                        onTap: () {
                          Get.defaultDialog(
                            contentPadding:
                                const EdgeInsets.only(top: 10, bottom: 10),
                            barrierDismissible: true,
                            radius: 10,
                            buttonColor: Pallete.successColor,
                            title: 'Ubah Password',
                            titleStyle: TextStyle(color: Pallete.successColor),
                            middleText: 'Anda yakin ingin mengubah password?',
                            textConfirm: 'Ubah',
                            textCancel: 'Batal',
                            cancelTextColor: Pallete.successColor,
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              userController.changePassword();
                            },
                          );
                        },
                        child: const Center(
                          child: Text(
                            "Ubah Password",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Pallete.primaryColor,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Pallete.primaryColor[200],
                        onTap: () async {
                          // this delete db sharepreferences user login
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.clear();

                          Get.offAllNamed(NameRoute.login);
                        },
                        child: const Center(
                          child: Text(
                            "Sign Out",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
