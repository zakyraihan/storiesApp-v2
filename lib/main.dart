import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app_api/api/api_service.dart';
import 'package:story_app_api/controller/auth_controller.dart';
import 'package:story_app_api/controller/camera_controller.dart';
import 'package:story_app_api/controller/story_controller.dart';
import 'package:story_app_api/ui/add_story_page.dart';
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
              ),
              ChangeNotifierProvider(
                create: (context) => CameraProvider(),
              )
            ],
            child: MaterialApp(
              builder: (context, child) {
                return CupertinoTheme(
                  data: const CupertinoThemeData(brightness: Brightness.light),
                  child: Material(
                    child: child,
                  ),
                );
              },
              theme: ThemeData.light(),
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              initialRoute: isAuthenticated ? '/' : '/login',
              routes: {
                '/': (context) => const HomeScreen(),
                '/register': (context) => const RegisterScreen(),
                '/login': (context) => const LoginScreen(),
                '/addstories': (context) => const AddStoryPage(),
              },
            ),
          );
        }
        return const SplashScreen();
      },
    );
  }
}
