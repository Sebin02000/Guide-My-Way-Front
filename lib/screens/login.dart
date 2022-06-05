 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:maps_app/screens/map_home.dart';
import 'package:http/http.dart' as http;

import '../utils/apiServices.dart';

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    try {
      final Uri url = Uri.parse("$URL_BASE/user/login");
      final resp = await http.post(url, body: {
        "email": data.name,
        "password": data.password,
      });
      if (resp.statusCode != 200) {
        final data = jsonDecode(resp.body);
        return data['message'];
      }
      debugPrint('Name: ${data.name}, Password: ${data.password}');
      return null;
    } catch (e) {
      return "Something went wrong";
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    try {
      final Uri url = Uri.parse("$URL_BASE/user/register");
      final resp = await http.post(url, body: {
        "email": data.name,
        "password": data.password,
        "name": data.name
      });
      if (resp.statusCode != 200) {
        final data = jsonDecode(resp.body);
        return data['message'];
      }
      return null;
    } catch (e) {
      return "Something went wrong";
    }
  }

  Future<String?> _recoverPassword(String name) async {
    try {
      debugPrint('Name: $name');
      final Uri url = Uri.parse("$URL_BASE/user/resetpassword");
      final resp = await http.post(url, body: {
        "email": name,
      });
      if (resp.statusCode != 200) {
        final data = jsonDecode(resp.body);
        return data['message'];
      }
      return null;
    } catch (e) {
      return "Something went wrong";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      loginAfterSignUp: false,
      title: 'Map',
      onLogin: _authUser,
      onSignup: _signupUser,
      theme: LoginTheme(
        primaryColor: Colors.blue,
        accentColor: Colors.green,
        errorColor: Colors.red,
        pageColorLight: Colors.green,
        pageColorDark: Colors.blue,
        titleStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        // buttonTheme: ButtonThemeData(
        //   buttonColor: Colors.blue,
        //   textTheme: ButtonTextTheme.primary,
        // ),
        // textFieldTheme: TextFieldTheme(
        //   decorationColor: Colors.blue,
        //   labelStyle: TextStyle(
        //     color: Colors.blue,
        //   ),
        // ),
      ),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MapHome(),
        ));
      },
      onRecoverPassword: (v) {
        debugPrint(v);
        _recoverPassword(v);
      },
    );
  }
}
