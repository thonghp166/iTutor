import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itutor/src/repository/user_repository.dart';
import 'package:itutor/src/screens/login/login_screen.dart';
import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/authentication/bloc.dart';
import 'screens/home_page.dart';
import 'screens/splash_screen.dart';
class App extends StatelessWidget {
  final UserRepository _userRepository;
  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          }
          if (state is Authenticated) {
            return HomePage();
          }
            return LoginScreen(userRepository: _userRepository);
        },
      ),
    );
  }
}