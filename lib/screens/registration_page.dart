import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/screens/main_page.dart';
import 'package:uber_clone/widgets/ProgressDialog.dart';

import '../brand_colors.dart';
import '../widgets/TaxiButton.dart';
import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'register';

  RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var fullNameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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

  void registerUser() async {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            const ProgressDialog(status: 'Registering you...'));
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      if (credential.user != null) {
        DatabaseReference dbRef =
            FirebaseDatabase.instance.ref("users/${credential.user!.uid}");

        await dbRef.set({
          'fullname': fullNameController.text,
          'phone': phoneController.text,
          'email': emailController.text
        });

        Navigator.of(context)
            .pushNamedAndRemoveUntil(MainPage.id, (route) => false);
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
              const Text('Create a Rider account',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold')),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  TextField(
                      keyboardType: TextInputType.text,
                      controller: fullNameController,
                      decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 10.0),
                  TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: 'Email address',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 10.0),
                  TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 10.0),
                  TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 40),
                  TaxiButton(
                      title: 'REGISTER',
                      onPressed: () {
                        if (fullNameController.text.length < 3) {
                          showSnackBar('Please enter your full name', context);
                          return;
                        }
                        registerUser();
                      },
                      color: BrandColors.colorGreen)
                ]),
              ),
              TextButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, LoginPage.id, (route) => false),
                  child: const Text('Already have an account?,log in'))
            ],
          ),
        ),
      ),
    ));
  }
}
