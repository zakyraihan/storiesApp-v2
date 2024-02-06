import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app_api/controller/auth_controller.dart';
import 'package:story_app_api/controller/camera_controller.dart';
import 'package:story_app_api/controller/story_controller.dart';
import 'package:story_app_api/controller/theme_controller.dart';
import 'package:story_app_api/data/api/api_service.dart';
import 'package:story_app_api/data/preferences/preferences_helper.dart';
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
              ),
              ChangeNotifierProvider(
                create: (context) => ThemeProvider(
                  preferencesHelper: PreferencesHelper(
                      sharedPreferences: SharedPreferences.getInstance()),
                ),
              )
            ],
            child: Consumer<ThemeProvider>(
              builder: (context, provider, _) {
                return MaterialApp(
                  builder: (context, child) {
                    return CupertinoTheme(
                      data: CupertinoThemeData(
                        brightness: provider.isDarkTheme
                            ? Brightness.dark
                            : Brightness.light,
                      ),
                      child: Material(
                        child: child,
                      ),
                    );
                  },
                  theme: provider.themeData,
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  initialRoute: isAuthenticated ? '/' : '/login',
                  routes: {
                    '/': (context) => const HomeScreen(),
                    '/register': (context) => const RegisterScreen(),
                    '/login': (context) => const LoginScreen(),
                    '/addstories': (context) => const AddStoryPage(),
                  },
                );
              },
            ),
          );
        }
        return const SplashScreen();
      },
    );
  }
}
