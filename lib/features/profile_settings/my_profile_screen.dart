import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:lets_play/common/extensions/string_extensions.dart';
import 'package:lets_play/common/extensions/validationBuilder.dart';
import 'package:lets_play/features/profile/cubit/user_cubit.dart';

import '../../common/components/yellow_submit_button.dart';
import '../../common/constants/app_constants.dart';
import '../../common/constants/assets_images.dart';
import 'common/text_field_decoration.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyProfileScreenState();
  }
}

class MyProfileScreenState extends State<MyProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final SingleValueDropDownController genderController =
      SingleValueDropDownController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    initProfileFields();
  }

  void initProfileFields() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final user = context.read<UserCubit>().state.user!;
      firstNameController.text = user.firstname!;
      lastnameController.text = user.lastname!;
      emailController.text = user.email!;
      if (user.gender != null) {
        genderController.dropDownValue = DropDownValueModel(
            name: user.gender!.capitalize, value: user.gender!.capitalize);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.purple,
        elevation: 2,
        centerTitle: false,
        title: const Text("Edit profile", style: AppStyles.mont23SemiBold),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Center(
              child: Image.asset(
                Assets.backBtn,
                height: 22,
                color: Colors.white,
              ),
            )),
      ),
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: firstNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: ValidationBuilder(
                          requiredMessage: "First name is required")
                      .minLength(3)
                      .build(),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: DecorationTF.decorationProfileTF("First Name"),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                Flexible(
                    child: TextFormField(
                  controller: lastnameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: ValidationBuilder(
                          requiredMessage: "Last name is required")
                      .minLength(3)
                      .build(),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: DecorationTF.decorationProfileTF("Last Name"),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                )),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:
                      ValidationBuilder(requiredMessage: "Email is required")
                          .isValidEmail()
                          .build(),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: DecorationTF.decorationProfileTF("Email"),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: DropDownTextField(
                    controller: genderController,
                    clearOption: false,
                    enableSearch: false,
                    validator: (value) {
                      if (value == null) {
                        return "Gender field is required";
                      } else {
                        return null;
                      }
                    },
                    dropDownItemCount: 2,
                    dropDownList: const [
                      DropDownValueModel(name: 'Male', value: "Male"),
                      DropDownValueModel(name: 'Female', value: "Female"),
                    ],
                    onChanged: (val) {},
                    textFieldDecoration:
                        DecorationTF.decorationProfileTF("Gender"),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                YellowSubmitButton(
                  loading: false,
                  buttonText: "Save",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<UserCubit>().updateProfileInfo(
                          firstname: firstNameController.text,
                          lastname: lastnameController.text,
                          email: emailController.text,
                          gender: genderController.dropDownValue!.value
                              .toString()
                              .toLowerCase());
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
