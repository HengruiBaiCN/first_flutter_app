import 'dart:convert';
import 'dart:io';

import 'package:first_flutter_app/config.dart';
import 'package:first_flutter_app/models/customer.dart';
import 'package:first_flutter_app/models/category.dart';

import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken = base64Encode(utf8.encode("${Config.key}:${Config.secret}"));

    bool ret = false;

    try {
      var response = await Dio().post(Config.url + Config.custormerUrl,
          data: model.toJson(),
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Basic $authToken",
            HttpHeaders.contentTypeHeader: "application/json"
          }));

      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }

    return ret;
  }

  Future<List<Category>> getCategories() async {
    List<Category> data = [];

    try {
      String url =
          "${Config.url}${Config.categoryUrl}?consumer_key=${Config.key}&consumer_secret=${Config.secret}";
      var response = await Dio().get(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));
      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Category.fromJson(i),
            )
            .toList();
      }
    } on DioError catch (e) {
      print(e.response);
    }

    return data;
  }
}
