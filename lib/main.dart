import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:get/get_navigation/src/routes/transitions_type.dart' as Trans;
import 'package:tokomobil/controllers/home/home_controller.dart';
import 'package:tokomobil/models/user_model.dart';
import 'package:tokomobil/splash_screen_page.dart';
import 'package:tokomobil/static_data.dart';
import 'package:tokomobil/ui/auth/login_page.dart';
import 'package:tokomobil/ui/auth/lupa_password/cek_kode_page.dart';
import 'package:tokomobil/ui/auth/lupa_password/lupa_password_page.dart';
import 'package:tokomobil/ui/auth/lupa_password/ubah_password_page.dart';
import 'package:tokomobil/ui/auth/register_page.dart';
import 'package:tokomobil/ui/home/akun/profile_page.dart';
import 'package:tokomobil/ui/home/akun/ubah_password_profile_page.dart';
import 'package:tokomobil/ui/home/akun/ubah_profile_page.dart';
import 'package:tokomobil/ui/home/beli/beli_detail_page.dart';
import 'package:tokomobil/ui/home/beli/beli_page.dart';
import 'package:tokomobil/ui/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Digunakan untuk memaksa potrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Inisialisasi library hive (penyimpanan mirip SQLite)
  var appDocumentDirectory =
      await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(UserModelAdapter());
  // Run Aplikasi
  runApp(App());
}

final ThemeData appThemeData = ThemeData(
  scaffoldBackgroundColor: Color(0xFFF8F8F8),
  primaryColor: Colors.blueAccent,
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Roboto',
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(StaticData.screenWidth, StaticData.screenHeight),
      builder: () => GetMaterialApp(
          title: "Toko Mobile 076",
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          theme: appThemeData,
          defaultTransition: Trans.Transition.native,
          getPages: [
            GetPage(name: "/", page: () => SplashScreenPage()),
            GetPage(name: "/auth/login", page: () => LoginPage()),
            GetPage(name: "/auth/register", page: () => RegisterPage()),
            GetPage(
                name: "/auth/lupa_password", page: () => LupaPasswordPage()),
            GetPage(
                name: "/auth/lupa_password/cek_kode",
                page: () => CekKodePage()),
            GetPage(
                name: "/auth/lupa_password/ubah_password",
                page: () => UbahPasswordPage()),
            GetPage(name: "/home", page: () => HomePage(), binding: HomeBind()),
            GetPage(name: "/akun/profile", page: () => ProfilePage()),
            GetPage(name: "/akun/profile/ubah", page: () => UbahProfilePage()),
            GetPage(
                name: "/akun/profile/ubah_password",
                page: () => UbahPasswordProfilePage()),
            GetPage(name: "/user/beli", page: () => BeliPage()),
            GetPage(name: "/user/beli/detail", page: () => BeliDetailPage()),
          ]),
    );
  }
}

class HomeBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
