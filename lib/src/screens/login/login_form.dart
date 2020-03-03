import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:itutor/src/blocs/authentication/bloc.dart';
import 'package:itutor/src/blocs/login/bloc.dart';
import 'package:itutor/src/repository/user_repository.dart';
import 'package:itutor/src/screens/dialog/loading_dialog.dart';
import 'package:itutor/src/screens/dialog/msg_dialog.dart';
import 'package:itutor/src/screens/register/register_screen.dart';
import 'package:itutor/src/widgets/logo.dart';
import 'package:itutor/src/widgets/social_icons.dart';

import 'login_button.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPass = false;
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(
        width: screenSize.width,
        height: screenSize.height,
        allowFontScaling: true);
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state.isFailure) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(
            context, "Đăng nhập không thành công", "Vui lòng thử lại");
      }
      if (state.isSubmitting) {
        LoadingDialog.showLoadingDialog(context, "Đang đang nhập");
      }
      if (state.isSuccess) {
        LoadingDialog.hideLoadingDialog(context);
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Logo(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text(
                    "Đăng nhập",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Email không hợp lệ' : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Mật khẩu',
                        ),
                        obscureText: !_showPass,
                        autocorrect: false,
                      ),
                      GestureDetector(
                        onTap: onToggleShowPassword,
                        child: Icon(
                          _showPass ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: LoginButton(onPressed: _onFormSubmitted),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Text("Hoặc đăng nhập bằng",
                          style: TextStyle(
                              color: Color(0xff888888),
                              fontSize: 18,
                              fontFamily: "Poppins-Medium")),
                      SizedBox(height: ScreenUtil.getInstance().setHeight(30)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SocialIcons(
                            colors: [
                              Color(0xFF102397),
                              Color(0xFF187adf),
                              Color(0xFF00aaf8),
                            ],
                            iconData: FontAwesomeIcons.facebookF,
                              onPressed: signInFB,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          SocialIcons(
                            colors: [
                              Color(0xFFff4f38),
                              Color(0xFFff355d),
                            ],
                            iconData: FontAwesomeIcons.google,
                            onPressed: signInGG,
                          )
                        ],
                      ),
//                    SizedBox(height: ScreenUtil.instance.setHeight(20),),
//                    Text("Bạn là gia sư?",style: TextStyle(color: Color(0xff888888),fontSize: 18,fontFamily: "Poppins-Medium")),
                      SizedBox(
                        height: ScreenUtil.instance.setHeight(30),
                      ),
                      Text("Bạn chưa có tài khoản?",
                          style: TextStyle(
                              color: Color(0xff888888),
                              fontSize: 18,
                              fontFamily: "Poppins-Medium")),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.blue.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      onPressed: onSignUpClicked,
                      child: Text(
                        "Đăng ký",
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  void onToggleShowPassword() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void signInGG() {
    BlocProvider.of<LoginBloc>(context).add(
      LoginWithGooglePressed(),
    );
  }

  void signInFB(){
    BlocProvider.of<LoginBloc>(context).add(
      LoginWithFacebookPressed(),
    );
  }

  void onSignUpClicked() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return RegisterScreen(userRepository: _userRepository);
      }),
    );
  }
}
