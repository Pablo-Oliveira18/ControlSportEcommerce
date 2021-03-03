import 'package:controlsport_app_ecommerce/models/products/product_manager.dart';
import 'package:controlsport_app_ecommerce/models/usuarios/user_manager.dart';
import 'package:controlsport_app_ecommerce/screen/base/base_screen.dart';
import 'package:controlsport_app_ecommerce/screen/login/login_screen.dart';
import 'package:controlsport_app_ecommerce/screen/signup(Cadastro)/cadastro_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Sport Control',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/cadastro':
              return MaterialPageRoute(builder: (_) => CadastroUserScreen());
            case '/base':
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
