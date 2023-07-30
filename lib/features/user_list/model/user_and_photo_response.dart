// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:user_lister_mobile_app/features/user_list/model/photo_response.dart';
import 'package:user_lister_mobile_app/features/user_list/model/user_list_response.dart';

class UserAndPhotoResponse {
  final User? userResponse;
  final PhotoResponse? photoResponse;
  UserAndPhotoResponse({
    this.userResponse,
    this.photoResponse,
  });

  factory UserAndPhotoResponse.fromJson(Map<String, dynamic> json) {
    return UserAndPhotoResponse(
      userResponse: json['userResponse'] != null ? User.fromJson(json['userResponse'] as Map<String, dynamic>) : null,
      photoResponse:
          json['photoResponse'] != null ? PhotoResponse.fromJson(json['photoResponse'] as Map<String, dynamic>) : null,
    );
  }

  // UserAndPhotoResponse sınıfını JSON verisine çevirme (toJson)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userResponse != null) {
      data['userResponse'] = userResponse!.toJson();
    }
    if (photoResponse != null) {
      data['photoResponse'] = photoResponse!.toJson();
    }
    return data;
  }

  @override
  bool operator ==(covariant UserAndPhotoResponse other) {
    if (identical(this, other)) return true;

    return other.userResponse == userResponse && other.photoResponse == photoResponse;
  }

  @override
  int get hashCode => userResponse.hashCode ^ photoResponse.hashCode;
}
