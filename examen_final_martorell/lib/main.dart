import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'preferences/preferences.dart';
import 'screens/screens.dart';
import 'services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => UserService())],
    child:MyApp()));
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: 'login',
      routes: {
        'login':(_) =>  LoginScreen(),
        'home': (_) => HomeScreen(),
        'detail': (_) => DetailScreen(),
      },
    );
  }
}
