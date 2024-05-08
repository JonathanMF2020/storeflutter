import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapi/presentation/asset.dart';
import 'package:storeapi/presentation/auth/bloc/auth_bloc.dart';
import 'package:storeapi/presentation/color.dart';
import 'package:storeapi/presentation/widgets_app_custom.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usuarioInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  @override
  void initState() {
    usuarioInput.text = "mor_2314";
    passwordInput.text = "83r5^_";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(

        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Asset.LOGO),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    WidgetsAppCustom.InputStore(
                        usuarioInput, "Usuario", Icons.person,
                        esPassword: false),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: WidgetsAppCustom.InputStore(
                          passwordInput, "Password", Icons.password,
                          esPassword: true),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primerColor,
                  elevation: 0,
                ),
                onPressed: () {
                  if (usuarioInput.text.isNotEmpty && passwordInput.text.isNotEmpty) {
                    try{
                      BlocProvider.of<AuthBloc>(context).add(AuthLoginService(usuarioInput.text, passwordInput.text));
                    }on DioException catch (e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("$e"),
                      ));
                    }


                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("No has llenado todos los campos"),
                    ));
                  }
                },
                child: const Text(
                  "Ingresar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
