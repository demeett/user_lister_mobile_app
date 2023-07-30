import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_lister_mobile_app/core/utils/debouncer.dart';
import 'package:user_lister_mobile_app/features/user_list/cubit/user_list_cubit.dart';

class SearchTextFormField extends StatelessWidget {
  const SearchTextFormField({
    super.key,
    required this.controller,
    required this.debouncer,
  });

  final TextEditingController controller;
  final Debouncer debouncer;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (value) {
        debouncer.run(() async {
          if (value.isNotEmpty) {
            await context.read<UserListCubit>().search(value);
          } else {
            context.read<UserListCubit>().refresh();
          }
        });
      },
      cursorHeight: 20,
      decoration: InputDecoration(
        suffixIcon: Padding(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
                onPressed: () {
                  controller.clear();
                  context.read<UserListCubit>().refresh();
                },
                icon: const Icon(Icons.clear))),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
      ),
    );
  }
}
