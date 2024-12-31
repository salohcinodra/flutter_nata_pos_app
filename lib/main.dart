import 'package:flutter/material.dart';
import 'package:flutter_nata_pos_app/core/constants/colors.dart';
import 'package:flutter_nata_pos_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_nata_pos_app/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_nata_pos_app/data/datasources/product_local_datasource.dart';
import 'package:flutter_nata_pos_app/data/datasources/product_remote_datasource.dart';
import 'package:flutter_nata_pos_app/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_nata_pos_app/presentation/auth/login_page.dart';
import 'package:flutter_nata_pos_app/presentation/home/bloc/local_product/local_product_bloc.dart';
import 'package:flutter_nata_pos_app/presentation/home/pages/dashboard_page.dart';
import 'package:flutter_nata_pos_app/presentation/setting/bloc/sync_product/sync_product_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

import 'presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => SyncProductBloc(ProductRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              LocalProductBloc(ProductLocalDatasource.instance),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.primary,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.primary,
            ),
          ),
        ),
        home: FutureBuilder<bool>(
            future: AuthLocalDatasource().isAuthDataExists(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  return const DashboardPage();
                } else {
                  return const LoginPage();
                }
              }
              return const Scaffold(
                body: Center(
                  child: Text('error'),
                ),
              );
            }),
      ),
    );
  }
}
