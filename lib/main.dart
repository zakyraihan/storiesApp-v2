import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_api/api/api_service.dart';
import 'package:story_app_api/controller/auth_controller.dart';
import 'package:story_app_api/controller/story_controller.dart';
import 'package:story_app_api/ui/home.dart';
import 'package:story_app_api/ui/login_screen.dart';
import 'package:story_app_api/ui/register_screen.dart';
import 'package:story_app_api/ui/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isAuthenticated = await AuthController().isAuthenticated();

  runApp(MyApp(isAuthenticated: isAuthenticated));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isAuthenticated}) : super(key: key);

  final bool isAuthenticated;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 3)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) =>
                    StoriesProvider(apiService: ApiService('')),
              )
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              initialRoute: isAuthenticated ? '/' : '/login',
              routes: {
                '/': (context) => const HomeScreen(),
                '/register': (context) => const RegisterScreen(),
                '/login': (context) => const LoginScreen(),
              },
            ),
          );
        }
        return const SplashScreen();
      },
    );
  }
}
