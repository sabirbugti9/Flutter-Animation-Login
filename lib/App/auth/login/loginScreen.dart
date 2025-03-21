import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reqres_app/App/HomeScreen/HomeScreen.dart';
import 'package:reqres_app/App/auth/login/loginUI.dart';
import 'package:reqres_app/App/auth/signUp/SignUpScreen.dart';
import 'package:reqres_app/network/dataModel/LoginSuccess.dart';
import 'package:reqres_app/network/model/result.dart';
import 'package:reqres_app/network/remote_data_source.dart';
import 'package:reqres_app/network/util/helper.dart';
import 'package:reqres_app/widget/dismissKeyBoardView.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool validEmail = false, validPassword = false, rememberMe = true;

  void goBack(context) {
    Helper().goBack();
  }

  void changeVaildEmail(bool value) {
    setState(() {
      validEmail = value;
    });
  }

  void changevalidPassword(bool value) {
    setState(() {
      validPassword = value;
    });
  }

  void changeRemember(bool value) {
    setState(() {
      rememberMe = value;
    });
  }

  void loginUser() {
    GetStorage box = GetStorage();
    if (_formKey.currentState!.validate()) {
      Helper().dismissKeyBoard(context);
      Helper().showLoading();
      RemoteDataSource apiResponse = RemoteDataSource();
      var parameter = {
        "email": "eve.holt@reqres.in",
        "password": "cityslickasss"
      };
      Future<Result> result = apiResponse.userLogin(parameter);
      result.then((value) {
        if (value is SuccessState) {
          Helper().hideLoading();
          var res = value.value as LoginSuccess;
          print("Loand and save the result${res.token!}");
          box.write('token', res.token);
          Get.off(HomeScreen());
        } else {}
      });
    } else {
      // Helper().vibratPhone();
    }
  }

  void createAccount() {
    Helper().dismissKeyBoard(context);
    Helper().goToPage(context: context, child: const SignUpScreen());
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyBoardView(child: LoginScreenUI(emailController: emailController, passwordController: passwordController, validEmail: validEmail, validPassword: validPassword, changeVaildEmail: changeVaildEmail, changevalidPassword: changevalidPassword, changeRemember: changeRemember, rememberMe: rememberMe, formKey: _formKey, loginUser: loginUser, createAccount: createAccount));
  }
}
