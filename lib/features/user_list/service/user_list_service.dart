import 'dart:convert';
import 'dart:io';

import 'package:user_lister_mobile_app/core/constants/service_constant.dart';
import 'package:user_lister_mobile_app/core/network/app_http_client.dart';

import '../model/user_list_response.dart';

class UserListService {
  //final client = http.Client();

  Future<List<User>> fetchUsers() async {
    try {
      final response = await AppHttpClient.instance.service.get(Uri.parse(ServiceConstant.baseUrl));
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> userListJson = json.decode(response.body);
        return userListJson.map((e) => User.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
