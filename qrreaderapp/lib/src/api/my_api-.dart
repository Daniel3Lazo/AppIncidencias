
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:qrreaderapp/src/models/loginModel.dart';
import 'package:qrreaderapp/src/pages/home_page.dart';
import 'package:qrreaderapp/src/utils/dialogs.dart';

class MyAPI {
  MyAPI._internal();
  static final MyAPI _instance = MyAPI._internal();
  static MyAPI get instance => _instance;
  final Dio _dio = Dio();

  Future<void> register(
    BuildContext context, {
    required String nombres,
    required String apellidos,
    required String email,
    required String password,
  }) async {
    final ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      // ignore: unused_local_variable
      final Response response = await _dio.post(
        'http://yeowtec.com/api/Usuario/Insert_Usuario.php',
        data: {
          "US_Nombres": nombres,
          "US_Apellidos": apellidos,
          "US_Email": email,
          "US_Contrasena": password,
        },
      );
      progressDialog.dismiss();

      Navigator.pushNamedAndRemoveUntil(
        context,
        HomePage.routeName,
        (_) => false,
      );
    } catch (e) {
      progressDialog.dismiss();
      if (e is DioError) {
        print(e.response?.statusCode);
        print(e.response?.data);
        Dialogs.info(
          context,
          title: "ERROR",
          content: e.response?.statusCode == 409
              ? 'Duplicated email or username'
              : e.message,
        );
      } else {
        print(e);
      }
    }
  }

  Future<void> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    final ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      final Response response = await _dio.post(
        'http://yeowtec.com/api/Usuario/login.php',
        data: {
          "US_Email": email,
          "US_Contrasena": password,
        },
      );

      var lista =
          response.data.entries.map((entry) => "${entry.value}").toList();

      Authent.metodo(lista[2]);

      progressDialog.dismiss();

      Navigator.pushNamedAndRemoveUntil(
        context,
        HomePage.routeName,
        (_) => false,
      );
    } catch (e) {
      progressDialog.dismiss();
      if (e is DioError) {
        print(e.response?.statusCode);
        print(e.response?.data);
        String? message = e.message;
        if (e.response?.statusCode == 404) {
          message = "User not found";
        } else if (e.response?.statusCode == 403) {
          message = "Invalid password";
        }

        Dialogs.info(
          context,
          title: "ERROR ",
          content: message,
        );
      } else {
        print(e);
      }
    }
  }
}
