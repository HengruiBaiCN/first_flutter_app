// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
// import 'package:flutter/material.dart';
import 'package:first_flutter_app/models/cart_request_model.dart';
import 'package:first_flutter_app/models/cart_response_model.dart';
import 'package:http/http.dart' as http;

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
    } on DioException catch (e) {
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
      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Product.fromJson(i),
            )
            .toList();
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
    int? categoryId,
    int? tagId,
    List<int>? relatedIds,
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
        parameter += "&per_page=$pageSize";
      }
      if (pageNumber != null) {
        parameter += "&page=$pageNumber";
      }
      if (tagName != null) {
        parameter += "&tag=$tagName";
      }
      if (categoryId != null) {
        parameter += "&category=$categoryId";
      }
      if (tagId != null) {
        parameter += "&tag=$tagId";
      }
      if (relatedIds != null) {
        parameter += "&include=${relatedIds.join(',').toString()})}";
      }
      if (sortBy != null) {
        parameter += "&orderby=$sortBy";
      }
      if (sortOrder != null) {
        parameter += "&order=$sortOrder";
      }

      String url = "${Config.url}products?$parameter&${Config.credentials}";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // print('object');
        data = (json.decode(response.body) as List)
            .map(
              (i) => Product.fromJson(i),
            )
            .toList();
      }
    } on DioException catch (e) {
      print('entering dio exception');
      print(e.response);
    }
    return data;
  }

  // Future<List<Category>> getMedias() async {
  //   List<Category> data = [];

  //   try {
  //     String url =
  //         "${Config.url}${Config.mediaUrl}?${Config.credentials}&per_page=100";
  //     var response = await Dio().get(url,
  //         options: Options(
  //             headers: {HttpHeaders.contentTypeHeader: "application/json"}));
  //     if (response.statusCode == 200) {
  //       return json.decode(response.data);
  //     }
  //   } on DioException catch (e) {
  //     print(e.response);
  //   }

  //   return data;
  // }

  Future<CartResponseModel?> addToCart(CartRequestModel model) async {
    model.userId = int.parse(Config.userID);

    CartResponseModel cartResponseModel;

    try {
      var response = await Dio().post(
          Config.storeUrl + Config.cartUrl + Config.addToCartUrl,
          data: model.toJson(),
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        cartResponseModel = CartResponseModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      print('Error adding product to cart: $e');
      print(Config.storeUrl + Config.cartUrl + Config.addToCartUrl);
      return null;
    }

    return cartResponseModel;
  }

  Future<CartResponseModel> getCartItems() async {
    CartResponseModel responseModel = CartResponseModel(
      status: '',
      data: [],
    );

    try {
      String url = Config.storeUrl + Config.userID + Config.credentials;

      var response = await Dio().get(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));
      if (response.statusCode == 200) {
        responseModel = CartResponseModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      print(e.response);
    }

    return responseModel;
  }
}
