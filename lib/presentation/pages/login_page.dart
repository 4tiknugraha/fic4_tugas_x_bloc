// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fic4_tugas_x_bloc/bloc/login/login_bloc.dart';
import 'package:fic4_tugas_x_bloc/bloc/register/register_bloc.dart';
import 'package:fic4_tugas_x_bloc/data/models/request/login_model.dart';
import 'package:fic4_tugas_x_bloc/data/models/request/register_model.dart';
import 'package:fic4_tugas_x_bloc/presentation/pages/home_page.dart';
import 'package:fic4_tugas_x_bloc/presentation/pages/register_page.dart';

import '../../data/localsources/auth_local_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  // get _isPasswordValidated => true;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    isLogin();
    Future.delayed(Duration(seconds: 2));
    super.initState();
  }

  void isLogin() async {
    final isTokenExist = await AuthLocalStorage().isTokenExist();
    if (isTokenExist) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
    }
  }

  @override
  void dispose() {
    super.dispose();

    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text('Login',
          style: TextStyle(
          color: Color(0xff1f005c),
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w900,
          fontSize: 45,
          ),
        ),
      ),

      body: Container (
         decoration:  BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:  const  Radius.circular(40.0),
            topRight: const  Radius.circular(40.0)
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0, 3),
            colors: const <Color>[
              Color.fromARGB(255, 13, 4, 31),
              Color(0xff5b0060),
              Color(0xff870160),
              Color(0xffac255e),
              Color(0xffca485c),
              Color(0xffe16b5c),
              Color(0xfff39060),
              Color(0xffffb56b),
            ],
            tileMode: TileMode.mirror,

          ),
         ),
        child: Padding (
          padding: const EdgeInsets.all(26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle : TextStyle(color: Colors.white),
                  fillColor: Colors.transparent,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(height: 10),
              TextField(
                style: TextStyle(color: Colors.white),
                obscureText: true,
                decoration: InputDecoration(
                labelText: 'Password',
                labelStyle : TextStyle(color: Colors.white),
                  fillColor: Colors.transparent,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                controller: passwordController,
              ),
              const SizedBox(
                height: 46,
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginLoaded) {
                    emailController!.clear();
                    passwordController!.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.blue,
                        content: Text('Success Login')),
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const HomePage();
                    }));
                  }
                },
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      final requestModel = LoginModel(
                        email: emailController!.text,
                        password: passwordController!.text,
                      );

                      context
                          .read<LoginBloc>()
                          .add(DoLoginEvent(loginModel: requestModel));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.pinkAccent,
                        minimumSize: const Size.fromHeight(50),
                        shadowColor: Colors.grey.withOpacity(0.4),
                        elevation: 24, // e
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),

                    child: const Text('Login',
                    style: TextStyle(color: Colors.white),
                    ),

                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const RegisterPage();
                  }));
                },
                // child: const Text(
                //   'Belum Punya Akun? Register',
                //   style: TextStyle(color : Colors.white),
                // ),
                child: RichText(
                  text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'New Member? ', style: TextStyle(color: Colors.white)),
                      TextSpan(text: 'Register now ', style: TextStyle(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w700,
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
