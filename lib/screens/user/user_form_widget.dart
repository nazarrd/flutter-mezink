import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_values.dart';
import '../../extension/screen_util.dart';
import '../../models/user_model.dart';
import '../../providers/user_provider.dart';
import '../../widgets/button_default.dart';
import '../../widgets/dropdown_default.dart';
import '../../widgets/textfield_default.dart';

class UserFormWidget extends StatelessWidget {
  const UserFormWidget({super.key, this.data, this.readOnly = false});

  final UserData? data;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
    UserData? user = UserData.fromJson(data?.toJson() ?? {});
    user.grade ??= grades.first;

    return StatefulBuilder(builder: (context, update) {
      return Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          readOnly ? 'Influencer Details' : 'Add Influencer',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Form(
          key: formKey,
          child: Container(
            width: 50.w,
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Column(children: [
              const SizedBox(height: 8),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: readOnly
                    ? null
                    : () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(type: FileType.image);
                        if (result != null) {
                          final pickedFile = result.files.first;
                          final bytes = Uint8List.fromList(pickedFile.bytes!);
                          update(() => user.tempImage = bytes);
                        }
                      },
                child: user.tempImage != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: MemoryImage(user.tempImage!),
                        child: user.tempImage == null
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: user.avatar == null
                            ? null
                            : NetworkImage(user.avatar!),
                        child: user.avatar == null
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
              ),
              const SizedBox(height: 24),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  width: 24.5.w,
                  child: TextFieldDefault(
                    readOnly: readOnly,
                    label: 'First Name',
                    hintText: 'enter first name',
                    initialValue: user.firstName,
                    onChanged: (value) => update(() => user.firstName = value),
                    margin: const EdgeInsets.only(bottom: 16),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'first name cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 24.5.w,
                  child: TextFieldDefault(
                    readOnly: readOnly,
                    label: 'Last Name',
                    hintText: 'enter last name',
                    initialValue: user.lastName,
                    onChanged: (value) => update(() => user.lastName = value),
                    margin: const EdgeInsets.only(bottom: 16),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'last name cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  width: 16.w,
                  child: AbsorbPointer(
                    absorbing: readOnly,
                    child: DropdownDefault(
                      label: 'Grades',
                      hintText: 'select grade',
                      data: grades,
                      selected: user.grade,
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 16),
                      onChanged: (value) => update(() => user.grade = value),
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        height: 1.75,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                  child: TextFieldDefault(
                    readOnly: readOnly,
                    label: 'Followers',
                    hintText: 'ex: 100k',
                    initialValue: user.followers,
                    margin: const EdgeInsets.only(bottom: 16),
                    onChanged: (value) => update(() => user.followers = value),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'followers cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 16.w,
                  child: TextFieldDefault(
                    readOnly: readOnly,
                    label: 'Engagement Rate',
                    hintText: 'ex: 10%',
                    initialValue: user.engagement,
                    margin: const EdgeInsets.only(bottom: 16),
                    onChanged: (value) => update(() => user.engagement = value),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'engagement rate cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  width: 24.5.w,
                  child: TextFieldDefault(
                    readOnly: readOnly,
                    label: 'Tags',
                    hintText: 'separate with comma',
                    initialValue: user.tags,
                    onChanged: (value) => update(() => user.tags = value),
                    margin: const EdgeInsets.only(bottom: 16),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'tags cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 24.5.w,
                  child: TextFieldDefault(
                    readOnly: readOnly,
                    label: 'Hashtags',
                    hintText: 'separate with comma',
                    initialValue: user.hashtags,
                    onChanged: (value) => update(() => user.hashtags = value),
                    margin: const EdgeInsets.only(bottom: 16),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'hashtags cannot be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ]),
            ]),
          ),
        ),
        Row(mainAxisSize: MainAxisSize.min, children: [
          ButtonDefault(
            'Close',
            onPressed: () => Navigator.of(context).pop(),
          ),
          if (!readOnly) const SizedBox(width: 10),
          if (!readOnly)
            ButtonDefault(
              'Save',
              fillColor: AppColors.primary,
              textColor: Colors.white,
              onPressed: () {
                UserProvider provider = context.read<UserProvider>();
                if (formKey.currentState!.validate()) {
                  Navigator.of(context).pop();
                  if (data == null) {
                    provider.addUser(user);
                  } else {
                    provider.editUser(user);
                  }
                }
              },
            ),
        ]),
        const SizedBox(height: 4),
      ]);
    });
  }
}
