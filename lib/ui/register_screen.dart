import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:story_app_api/controller/auth_controller.dart';
import 'package:story_app_api/widget/my_textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObscure = true;
  TextEditingController nama = TextEditingController(),
      email = TextEditingController(),
      password = TextEditingController();

  bool loading = false;

  saveRegister() {
    setState(() {
      loading = true;
    });

    AuthController()
        .registerProses(nama.text, email.text, password.text)
        .then((value) {
      if (value != null) {
        AwesomeDialog(
          context: context,
          title: 'Succes',
          desc: 'Register Berhasil',
          btnOkOnPress: () => Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false),
        ).show();
      } else {
        setState(() {
          loading = false;
        });
        AwesomeDialog(
          context: context,
          title: "Failed",
          desc: "Register Gagal",
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
                MyTextFieldWidget(
                  controller: nama,
                  label: 'Name',
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
                  onPressed: () => saveRegister(),
                  child: loading
                      ? const CircularProgressIndicator()
                      : const Text('Sign Up'),
                ),
                const SizedBox(height: 40),
                const Login(),
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

class Login extends StatelessWidget {
  const Login({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('You have an Account?'),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/login'),
          child: const Text('Login'),
        )
      ],
    );
  }
}
