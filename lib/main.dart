import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:storeapi/config/app_bloc_observer.dart';
import 'package:storeapi/presentation/app_root.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  print(dotenv.env['STRIPE_PUBLIC']!);
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLIC']!;
  Stripe.instance.applySettings();
  Bloc.observer = AppBlocObserver();
  runApp(const AppRoot());
}