import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key, this.onChanged, this.controller})
      : super(key: key);
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: TextFormField(
          controller: controller,
          onChanged: (term) {
            onChanged!(term);
          },
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            fillColor: AppColors.backGrey,
            focusColor: AppColors.backGrey,
            filled: true,
            prefixIcon: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.black54,
                  size: 30,
                )),
          ),
        ),
      ),
    );
  }
}

final SearchTextFieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5.0),
  borderSide: const BorderSide(color: Colors.transparent, width: 0),
);
