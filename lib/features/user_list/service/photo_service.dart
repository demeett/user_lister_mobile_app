import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:user_lister_mobile_app/core/network/app_http_client.dart';

import '../../../core/constants/service_constant.dart';
import '../model/photo_response.dart';

class PhotoService {
  Future<PhotoResponse?> getPhoto({int? id}) async {
    try {
      final response = await AppHttpClient.instance.service.get(Uri.parse("${ServiceConstant.photoUrl}$id/info"));
      if (response.statusCode == HttpStatus.ok) {
        final photoInfo = json.decode(response.body);
        return PhotoResponse.fromJson(photoInfo);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
