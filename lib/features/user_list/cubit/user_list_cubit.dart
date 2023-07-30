import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_lister_mobile_app/features/user_list/cubit/user_list_state.dart';
import 'package:user_lister_mobile_app/features/user_list/model/user_and_photo_response.dart';
import 'package:user_lister_mobile_app/features/user_list/service/photo_service.dart';
import 'package:user_lister_mobile_app/features/user_list/service/user_list_service.dart';

class UserListCubit extends Cubit<UserListState> {
  UserListCubit(this.service, this.photoService) : super(UserListState());
  final UserListService service;
  final PhotoService photoService;

  Future<void> fetchUsers() async {
    emit(state.copyWith(status: UserListStatus.loadingInProgress));
    final userResponse = await service.fetchUsers();
    List<UserAndPhotoResponse> userAndPhoto = [];
    for (var user in userResponse) {
      final photoResponse = await photoService.getPhoto(id: user.id);
      userAndPhoto.add(UserAndPhotoResponse(userResponse: user, photoResponse: photoResponse));
    }
    if (userResponse.isEmpty) {
      emit(state.copyWith(status: UserListStatus.failure));
    } else {
      emit(state.copyWith(
          userAndPhotoListResponse: userAndPhoto,
          initialUserAndPhotoListResponse: userAndPhoto,
          status: UserListStatus.success));
    }
  }

  void refresh() {
    final initialValues = state.initialUserAndPhotoListResponse;
    emit(state.copyWith(
      userAndPhotoListResponse: initialValues,
    ));
  }

  Future<void> search(String userName) async {
    final list = state.userAndPhotoListResponse;
    final search = list
        .where((element) => (element.userResponse?.username?.toLowerCase() ?? "").contains(userName.toLowerCase()))
        .toList();

    emit(state.copyWith(userAndPhotoListResponse: search, status: UserListStatus.success));
  }
}
