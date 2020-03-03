import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itutor/src/blocs/authentication/bloc.dart';
import 'package:itutor/src/blocs/register/register_bloc.dart';
import 'package:itutor/src/blocs/register/register_event.dart';
import 'package:itutor/src/blocs/register/register_state.dart';
import 'package:itutor/src/screens/dialog/loading_dialog.dart';
import 'package:itutor/src/screens/dialog/msg_dialog.dart';
import 'package:itutor/src/screens/register/register_button.dart';
import 'package:itutor/src/widgets/logo.dart';

class RegisterForm extends StatefulWidget {

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  RegisterBloc _registerBloc;

  bool _showPass = false;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
  }


  @override
  Widget build(BuildContext context) {
    return  BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isFailure) {
          LoadingDialog.hideLoadingDialog(context);
          MsgDialog.showMsgDialog(context, "Đăng ký không thành công", "Vui lòng thử lại");
        }
        if (state.isSubmitting) {
          LoadingDialog.showLoadingDialog(context, "Đang đang ký");
        }
        if (state.isSuccess) {
          LoadingDialog.hideLoadingDialog(context);
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<RegisterBloc,RegisterState>(
        builder: (context,state) {
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Logo(),
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
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      labelText: 'Số điện thoại',
                    ),
                    keyboardType: TextInputType.phone,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPhoneValid ? 'Số điện thoại không hợp lệ' : null;
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
                        autovalidate: true,
                        autocorrect: false,
                        validator: (_) {
                          return !state.isPasswordValid ? 'Mật khẩu không hợp lệ' : null;
                        },
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
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: TextFormField(
                    controller: _rePasswordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Nhập lại mật khẩu',
                    ),
                    obscureText: !_showPass,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isRePasswordValid ? 'Mật khẩu không trùng khớp' : null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,10,20,20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: RegisterButton(
                      onPressed: _onFormSubmitted,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Center(
                    child: Text(
                      "By creating an account you agree to our",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Center(
                    child: Text(
                      "Terms of Service and Privacy Policy",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }



  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        rePass: _rePasswordController.text
      ),
    );
  }


  void onToggleShowPassword() {
    setState(() {
      _showPass = !_showPass;
    });
  }

}
