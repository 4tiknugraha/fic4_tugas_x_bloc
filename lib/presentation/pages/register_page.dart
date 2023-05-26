import 'package:fic4_tugas_x_bloc/bloc/register/register_bloc.dart';
import 'package:fic4_tugas_x_bloc/data/models/request/register_model.dart';
import 'package:fic4_tugas_x_bloc/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController!.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text('Register',
         style: TextStyle(
          color: Color(0xff1f005c),
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w900,
          fontSize: 45,
          ),
        ),
      ),

      body: Container(
        decoration:  const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:  Radius.circular(40.0),
            topRight: Radius.circular(40.0)
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0, 3),
            colors: <Color>[
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                controller: nameController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                controller: emailController,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                controller: passwordController,
              ),
              const SizedBox(
                height: 16,
              ),
              BlocConsumer<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterLoaded) {
                    nameController!.clear();
                    emailController!.clear();
                    passwordController!.clear();
                    //navigasi
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          backgroundColor: Colors.blue,
                          content: Text(
                              'success register with id: ${state.model.id}')),
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const LoginPage();
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
                      final requestModel = RegisterModel(
                        name: nameController!.text,
                        email: emailController!.text,
                        password: passwordController!.text,
                      );

                      context
                          .read<RegisterBloc>()
                          .add(SaveRegisterEvent(request: requestModel));
                    },
                    child: const Text('Register'),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));
                },
                child: const Text(
                  'Belum Punya Akun? Register',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
