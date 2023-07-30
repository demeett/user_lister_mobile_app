import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_lister_mobile_app/core/constants/text_constants.dart';
import 'package:user_lister_mobile_app/core/utils/debouncer.dart';
import 'package:user_lister_mobile_app/core/extensions/size_extension.dart';
import 'package:user_lister_mobile_app/core/extensions/text_extension.dart';
import 'package:user_lister_mobile_app/features/user_list/cubit/user_list_cubit.dart';
import 'package:user_lister_mobile_app/features/user_list/cubit/user_list_state.dart';
import 'package:user_lister_mobile_app/features/user_list/service/photo_service.dart';
import 'package:user_lister_mobile_app/features/user_list/service/user_list_service.dart';
import 'package:user_lister_mobile_app/features/user_list/view/widgets/detail_dialog.dart';
import 'package:user_lister_mobile_app/features/user_list/view/widgets/search_text_form_field.dart';
import 'package:user_lister_mobile_app/features/user_list/view/widgets/user_list_tile.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserListCubit>(
      create: (context) => UserListCubit(UserListService(), PhotoService())..fetchUsers(),
      child: const UserListView(),
    );
  }
}

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  late TextEditingController controller;
  final debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<UserListCubit, UserListState>(builder: (context, state) {
      final status = state.status;
      switch (status) {
        case UserListStatus.initial:
          return const SizedBox.shrink();
        case UserListStatus.loadingInProgress:
          return const Center(child: CircularProgressIndicator());
        case UserListStatus.success:
          return UserListSuccessBody(controller: controller, debouncer: debouncer, state: state);
        case UserListStatus.failure:
          return const Center(child: Text("Failure"));
      }
    }));
  }
}

class UserListSuccessBody extends StatelessWidget {
  const UserListSuccessBody({
    super.key,
    required this.controller,
    required this.debouncer,
    required this.state,
  });

  final TextEditingController controller;
  final Debouncer debouncer;
  final UserListState state;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  TextConstants.userListApp,
                  style: context.xTextTheme.headlineSmall,
                ),
              ),
            ),
            SearchTextFormField(controller: controller, debouncer: debouncer),
            state.userAndPhotoListResponse.isEmpty
                ? SizedBox(
                    height: context.xScreenHeight / 2,
                    child: Center(child: Text(TextConstants.userNotFound, style: context.xTextTheme.headlineSmall)))
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.userAndPhotoListResponse.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: UserListTile(userAndPhotoResponse: state.userAndPhotoListResponse[index]),
                          onTap: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return DetailDialog(model: state.userAndPhotoListResponse[index]);
                                });
                          },
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
