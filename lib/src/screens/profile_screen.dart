import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itutor/src/blocs/authentication/authentication_bloc.dart';
import 'package:itutor/src/blocs/authentication/bloc.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin cá nhân"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: RaisedButton(
          onPressed: (){
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
          },
          child: Text("Log out"),        ),
      ),
    );
  }
}