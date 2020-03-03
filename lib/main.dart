//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:itutor/src/app.dart';
//import 'package:itutor/src/blocs/authentication/authentication_bloc.dart';
//import 'package:itutor/src/blocs/simple_bloc_delegate.dart';
//import 'package:itutor/src/repository/user_repository.dart';
//
//import 'src/blocs/authentication/bloc.dart';
//
//void main() {
//  WidgetsFlutterBinding.ensureInitialized();
////  SystemChrome.setSystemUIOverlayStyle(
////    SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
////  );
//  BlocSupervisor.delegate = SimpleBlocDelegate();
//  final userRepository = UserRepository();
//  runApp(
//    BlocProvider(
//      create: (context) => AuthenticationBloc(userRepository: userRepository)
//        ..add(AppStarted()),
//      child: App(userRepository: userRepository),
//    ),
//  );
//}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itutor/src/app.dart';
import 'package:itutor/src/blocs/authentication/bloc.dart';
import 'package:itutor/src/blocs/simple_bloc_delegate.dart';
import 'package:itutor/src/repository/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final _userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: _userRepository)
        ..add(AppStarted()),
      child: App(userRepository: _userRepository),
    ),
  );
}