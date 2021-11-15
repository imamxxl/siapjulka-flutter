import 'package:get/get.dart';
import 'package:siapjulka/pages/dashboard_page.dart';
import 'package:siapjulka/pages/home_page.dart';
import 'package:siapjulka/pages/login_page.dart';
import 'package:siapjulka/pages/profile_page.dart';
import 'package:siapjulka/routes/name_route.dart';

class AppRoute {
  static final pages = [
    GetPage(
      name: NameRoute.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: NameRoute.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: NameRoute.profil,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: NameRoute.dashboard,
      page: () => const DashboardPage(),
    ),
    GetPage(
      name: NameRoute.search,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: NameRoute.scan,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: NameRoute.laporan,
      page: () => const ProfilePage(),
    ),
  ];
}
