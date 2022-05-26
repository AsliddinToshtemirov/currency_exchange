import 'dart:convert';
import 'dart:io';

import 'package:currency_exchange/api/api_response.dart';
import 'package:flutter/material.dart';

import '../models/currency_rate.dart';
import 'package:http/http.dart' as http;
import 'package:currency_exchange/models/currency_rate.dart';

class Mainprovider extends ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.inilial("Data is loading ");

  final List<CurrencyRate> _currencyList = [];

  ApiResponse get response {
    return _apiResponse;
  }

  List<CurrencyRate> get currencies {
    return _currencyList;
  }

  Future<ApiResponse> getCurrencyRate() async {
    String url = "https://nbu.uz/uz/exchange-rates/json/";

    Uri myUrl = Uri.parse(url);

    try {
      var response = await http.get(myUrl);

      List data = jsonDecode(response.body);
      _currencyList.clear();

      for (var element in data) {
        _currencyList.add(CurrencyRate.fromJson(element));
      }
      _apiResponse = ApiResponse.complated(_currencyList);
    } catch (e) {
      if (e is SocketException) {
        _apiResponse = ApiResponse.error("No internet connection  ");
      }
      _apiResponse = ApiResponse.error(e.toString());
    }
    return _apiResponse;
  }
}
