import 'dart:convert';
import 'dart:io';

import 'package:first_flutter_app/config.dart';
import 'package:first_flutter_app/models/customer.dart';
import 'package:first_flutter_app/models/category.dart';

import 'package:dio/dio.dart';
import 'package:first_flutter_app/models/product.dart';
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
          "${Config.url}${Config.categoryUrl}?${Config.credentials}&per_page=100";
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
    } on DioException catch (e) {
      print(e.response);
    }

    return data;
  }

  Future<List<Product>> getProducts() async {
    List<Product> data = [];

    try {
      String url =
          "${Config.url}${Config.productUrl}?${Config.credentials}&per_page=100";
      var response = await Dio().get(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));
      if (response.statusCode == 400) {
        data = response.data;
      }
    } on DioException catch (e) {
      print(e.response);
    }

    return data;
  }

  Future<List<Product>> getProductsByTag({
    int? pageNumber,
    int? pageSize,
    String? strSearch,
    String? tagName,
    String? categoryId,
    String? sortBy,
    String? sortOrder = 'asc',
  }) async {
    List<Product> data = [];

    try {
      String parameter = "";

      if (strSearch != null) {
        parameter += "&search=$strSearch";
      }
      if (pageSize != null) {
        parameter += "$parameter&per_page=$pageSize";
      }
      if (pageNumber != null) {
        parameter += "$parameter&page=$pageNumber";
      }
      if (tagName != null) {
        parameter += "$parameter&tag=$tagName";
      }
      if (categoryId != null) {
        parameter += "$parameter&category=$categoryId";
      }
      if (sortBy != null) {
        parameter += "$parameter&orderby=$sortBy";
      }
      if (sortOrder != null) {
        parameter += "$parameter&order=$sortOrder";
      }

      String url =
          "${Config.url}${Config.productUrl}?${Config.credentials}&${parameter.toString()}";
      var response = await Dio().get(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));
      if (response.statusCode == 400) {
        data = response.data;
      }
    } on DioException catch (e) {
      print(e.response);
    }

    return data;
  }
}
