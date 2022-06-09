import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/screens/registration_page.dart';

import '../brand_colors.dart';
import '../widgets/ProgressDialog.dart';
import '../widgets/TaxiButton.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void showSnackBar(String title, BuildContext context) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void loginUser() async {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            const ProgressDialog(status: 'Logging you in...'));

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      if (credential.user != null) {
        DatabaseReference dbRef =
            FirebaseDatabase.instance.ref("users/${credential.user!.uid}");

        final dbSnap = await dbRef.once();
        if (dbSnap.snapshot.exists) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(MainPage.id, (route) => false);
        }
      }
    } catch (error) {
      Navigator.of(context).pop();
      showSnackBar(error.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 70),
              const Image(
                  alignment: Alignment.center,
                  width: 100.0,
                  height: 100.0,
                  image: AssetImage('assets/images/logo.png')),
              const SizedBox(height: 40),
              const Text('Sign In as a Rider',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold')),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                          labelText: 'Email address',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 10.0),
                  TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 40),
                  TaxiButton(
                      title: 'LOGIN',
                      onPressed: () {
                        loginUser();
                      },
                      color: BrandColors.colorGreen)
                ]),
              ),
              TextButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, RegistrationPage.id, (route) => false),
                  child: const Text('Don\'t have an account, sign up here'))
            ],
          ),
        ),
      ),
    ));
  }
}
