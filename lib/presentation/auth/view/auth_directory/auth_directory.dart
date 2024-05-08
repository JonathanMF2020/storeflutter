import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapi/data/source/local/storage_auth.dart';
import 'package:storeapi/data/source/network/api_auth.dart';
import 'package:storeapi/data/usuarios_repository_impl.dart';
import 'package:storeapi/domain/usecase/auth/login.dart';
import 'package:storeapi/domain/usecase/auth/obtener_token.dart';
import 'package:storeapi/presentation/auth/bloc/auth_bloc.dart';
import 'package:storeapi/presentation/auth/view/login/login_page.dart';
import 'package:storeapi/presentation/navigator/view/navigation_directory_page.dart';

class AuthDirectoryPage extends StatefulWidget {
  const AuthDirectoryPage({super.key});

  @override
  State<AuthDirectoryPage> createState() => _AuthDirectoryPageState();
}

class _AuthDirectoryPageState extends State<AuthDirectoryPage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const LoginPage();
        }
        if (state is AuthSuccess) {
          return const NavigationDirectoryPage();
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Ha ocurrido un error: ${state.error}"),
          ));
        }
        return Container();
      },
    );
  }
}
