import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nata_pos_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_nata_pos_app/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import '../../core/constants/variables.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final url = Uri.parse('${Variables.baseUrl}/api/login');
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      developer.log('200');
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left('Failed to login');
    }
  }

  //logout
  Future<Either<String, bool>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/logout');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${authData?.token}',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return const Right(true);
    } else {
      return const Left('Failed to logout');
    }
  }
}
