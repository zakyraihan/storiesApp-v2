import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:story_app_api/controller/auth_controller.dart';
import 'package:story_app_api/widget/my_textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  TextEditingController nama = TextEditingController(),
      email = TextEditingController(),
      password = TextEditingController();

  bool loading = false;

  saveLogin() {
    setState(() {
      loading = true;
    });

    AuthController().loginProses(email.text, password.text).then((value) {
      if (value != null) {
        AwesomeDialog(
          context: context,
          title: 'Succes',
          desc: 'Login Berhasil',
          dialogType: DialogType.success,
          btnOkOnPress: () =>
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
        ).show();
      } else {
        setState(() {
          loading = false;
        });
        AwesomeDialog(
          context: context,
          title: "Failed",
          desc: "Login Gagal",
          dialogType: DialogType.error,
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.3,
                  child: Image.asset('assets/img/logo-removebg-preview.png'),
                ),
                const SizedBox(height: 20),
                MyTextFieldWidget(
                  controller: email,
                  label: 'Email',
                ),
                const SizedBox(height: 20),
                MyTextFieldWidget(
                  controller: password,
                  label: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () => setObscure(),
                    icon: isObscure
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                  obscureText: isObscure,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => saveLogin(),
                  child: loading
                      ? const CircularProgressIndicator()
                      : const Text('Sign In'),
                ),
                const SizedBox(height: 40),
                const Register(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setObscure() {
    setState(() {
      isObscure = !isObscure;
    });
  }
}

class Register extends StatelessWidget {
  const Register({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an Account?"),
        TextButton(
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, '/register', (route) => false),
          child: const Text('Sign Up'),
        )
      ],
    );
  }
}
