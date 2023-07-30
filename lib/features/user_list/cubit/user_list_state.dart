import 'package:flutter/foundation.dart';
import 'package:user_lister_mobile_app/features/user_list/model/user_and_photo_response.dart';

enum UserListStatus { initial, loadingInProgress, success, failure }

class UserListState {
  final UserListStatus status;

  final List<UserAndPhotoResponse> userAndPhotoListResponse;
  final List<UserAndPhotoResponse> initialUserAndPhotoListResponse;

  UserListState({
    this.initialUserAndPhotoListResponse = const [],
    this.userAndPhotoListResponse = const [],
    this.status = UserListStatus.initial,
  });

  UserListState copyWith(
      {UserListStatus? status,
      List<UserAndPhotoResponse>? userAndPhotoListResponse,
      List<UserAndPhotoResponse>? initialUserAndPhotoListResponse}) {
    return UserListState(
      status: status ?? this.status,
      initialUserAndPhotoListResponse: initialUserAndPhotoListResponse ?? this.initialUserAndPhotoListResponse,
      userAndPhotoListResponse: userAndPhotoListResponse ?? this.userAndPhotoListResponse,
    );
  }

  @override
  bool operator ==(covariant UserListState other) {
    if (identical(this, other)) return true;
    return other.status == status &&
        listEquals(other.initialUserAndPhotoListResponse, initialUserAndPhotoListResponse) &&
        listEquals(other.userAndPhotoListResponse, userAndPhotoListResponse);
  }

  @override
  int get hashCode => status.hashCode ^ initialUserAndPhotoListResponse.hashCode ^ userAndPhotoListResponse.hashCode;
}
