// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vetmobile/domain/auth/models/product_model.dart';

Future<List<ProductService>> fetchProductsServices({
  required String type,
  required String searchData,
  required int pageNumber,
  required int pageSize,
}) async {
  final queryParameters = {
    'type': type,
    'searchData': searchData,
    'pageNumber': pageNumber.toString(),
    'pageSize': pageSize.toString(),
  };

  final uri = Uri.https(
    'www.veterinariatomyhyope.somee.com',
    '/api/store/products_services',
    queryParameters,
  );

  print('Request URL: $uri');

  final response = await http.get(uri);

  print('Status Code: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> productsList = jsonResponse['data'];
    print('Products List: $productsList');
    return productsList.map((product) => ProductService.fromJson(product)).toList();
  } else {
    print('Error: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to load data from API');
  }
}
