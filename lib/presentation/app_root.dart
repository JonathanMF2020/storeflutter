import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapi/presentation/auth/bloc/auth_bloc.dart';
import 'package:storeapi/presentation/auth/view/auth_directory/auth_directory.dart';
import 'package:storeapi/presentation/navigator/bloc/navigator_bloc.dart';
import 'package:storeapi/presentation/theme.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  var theme = const CustomTheme();
  var themeMode = ThemeMode.dark;


  @override
  Widget build(BuildContext context) {
    return GetAuthenticationPresentation();
  }

  Widget GetAuthenticationPresentation() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          AuthBloc()..add(AuthLogin()),
        ),
        BlocProvider(
          create: (context) => NavigatorBloc()..add(GoHome()),
        ),
      ],
      child: MaterialApp(
          themeMode: themeMode,
          theme: theme.toThemeData(),
          darkTheme: theme.toThemeDataDark(),
          debugShowCheckedModeBanner: false,
          color: Colors.white,
          home: const AuthDirectoryPage()
      ),
    );
  }
}


