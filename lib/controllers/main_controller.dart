import 'package:elecciones/pages/home_page.dart';
import 'package:elecciones/pages/login_page.dart';
import 'package:elecciones/pages/principal_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainController extends GetxController {
  var page;
  @override
  void onInit() {
    super.onInit();
    final box = GetStorage();
    bool isTrue = box.read('login') ?? false;
    bool isEscuela = box.read('carga') ?? false;
    //ThemeData get theme => isDark ? ThemeData.dark() : ThemeData.light();
    //void changeTheme(bool val) => box.write('darkmode', val);
    if (isTrue) {
      if (isEscuela) {
        page = PrincipalPage();
      } else {
        page = HomePage();
        print('homePage');
      }
    } else {
      page = LoginPage();
      print('Login');
    }
  }
}
