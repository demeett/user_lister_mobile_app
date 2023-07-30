import 'package:flutter/material.dart';
import 'package:user_lister_mobile_app/core/constants/text_constants.dart';
import 'package:user_lister_mobile_app/core/extensions/size_extension.dart';
import 'package:user_lister_mobile_app/core/extensions/text_extension.dart';
import 'package:user_lister_mobile_app/features/user_list/model/user_and_photo_response.dart';

class DetailDialog extends StatelessWidget {
  const DetailDialog({super.key, required this.model});
  final UserAndPhotoResponse model;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Kenar yarıçapını istediğiniz değere ayarlayın.
      ),
      content: SizedBox(
        height: context.xScreenHeight / 2,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop(); // Dialogu kapat
                  },
                ),
              ),
              Center(
                child: SizedBox(
                  height: context.xScreenHeight / 5,
                  width: context.xScreenHeight / 5,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      model.photoResponse?.downloadUrl ?? "",
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 8),
                  child: Text(
                    "${model.userResponse?.name ?? ""} ",
                    style: context.xTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    model.userResponse?.username ?? "",
                    style: context.xTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: RichText(
                    text: TextSpan(style: context.xTextTheme.titleMedium, text: "${TextConstants.email}: ", children: [
                  TextSpan(
                      text: model.userResponse?.email ?? "",
                      style: context.xTextTheme.titleMedium?.copyWith(decoration: TextDecoration.underline))
                ])),
              ),
              _commontext(data: "${TextConstants.phone}: ${model.userResponse?.phone ?? ""}"),
              _commontext(
                  data:
                      "${TextConstants.address}: ${model.userResponse?.address?.street ?? ""} ${model.userResponse?.address?.suite ?? ""}"),
              _commontext(data: "${TextConstants.city}: ${model.userResponse?.address?.city ?? ""}"),
              _commontext(
                  data:
                      "${TextConstants.geo}: ${model.userResponse?.address?.geo?.lat ?? ""} / ${model.userResponse?.address?.geo?.lng ?? ""}"),
            ],
          ),
        ),
      ),
    );
  }

  Padding _commontext({
    String data = "",
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        data,
      ),
    );
  }
}
