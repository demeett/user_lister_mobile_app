import 'package:flutter/material.dart';
import 'package:user_lister_mobile_app/core/extensions/size_extension.dart';
import 'package:user_lister_mobile_app/features/user_list/model/user_and_photo_response.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
    required this.userAndPhotoResponse,
  });

  final UserAndPhotoResponse userAndPhotoResponse;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(userAndPhotoResponse.userResponse?.name ?? ''),
      subtitle: Text(
        userAndPhotoResponse.userResponse?.username ?? '',
      ),
      leading: ClipOval(
        child: Image.network(
          userAndPhotoResponse.photoResponse?.downloadUrl ?? "",
          fit: BoxFit.cover,
          height: context.xScreenHeight / 15,
          width: context.xScreenHeight / 15,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return const CircularProgressIndicator();
            }
            return child;
          },
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
