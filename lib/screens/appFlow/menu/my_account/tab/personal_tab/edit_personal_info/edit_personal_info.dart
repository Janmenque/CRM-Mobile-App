import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/response_personal.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/personal_tab/edit_personal_info/edit_personal_info_provider.dart';
import 'package:provider/provider.dart';

class EditPersonalInfo extends StatelessWidget {
  final ResponsePersonal? personalInfo;

  const EditPersonalInfo({Key? key, this.personalInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditPersonalInfoProvider(personalInfo),
      child: Consumer<EditPersonalInfoProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                tr("personal_info_edit"),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tr("gender*"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                  value: "Male",
                                  groupValue: provider.selectedGender,
                                  onChanged: (String? genderValue) {
                                    if (kDebugMode) {
                                      print("Radio $genderValue");
                                    }
                                    provider.genderSelectedValue(genderValue!);
                                    provider.genderType(genderValue);
                                  }),
                              Text(
                                tr("male"),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                  value: "Female",
                                  groupValue: provider.selectedGender,
                                  onChanged: (String? genderValue) {
                                    if (kDebugMode) {
                                      print("Radio $genderValue");
                                    }
                                    provider.genderSelectedValue(genderValue!);
                                    provider.genderType(genderValue);
                                  }),
                              Text(
                                tr("female"),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                  value: "Unisex",
                                  groupValue: provider.selectedGender,
                                  onChanged: (String? genderValue) {
                                    if (kDebugMode) {
                                      print("Radio $genderValue");
                                    }
                                    provider.genderSelectedValue(genderValue!);
                                    provider.genderType(genderValue);
                                  }),
                              Text(
                                tr("other"),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      tr("phone"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: provider.phoneTextController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 16),
                        hintText: tr("enter_phone_number"),
                        hintStyle: const TextStyle(fontSize: 12),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: provider.phoneError != null,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            provider.phoneError ?? "",
                            style: const TextStyle(color: Colors.red),
                          ),
                        )),
                    Visibility(
                        visible: provider.errorMessage != null &&
                            provider.phoneError == null,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            provider.errorMessage ?? "",
                            style: const TextStyle(color: Colors.red),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      tr("date_of_birth"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () => provider.selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.dateOfBirthDb != null
                                  ? "${provider.dateOfBirthDb!.toLocal()}"
                                      .split(" ")[0]
                                  : tr("select_date_of_birth"),
                              style: const TextStyle(fontSize: 14),
                            ),
                            const Icon(Icons.date_range_outlined)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      tr("address"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: provider.addressTextController,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 16),
                        hintText: tr("house_no_road_block_area_city"),
                        hintStyle: const TextStyle(fontSize: 12),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      tr("nationality"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: provider.nationalityTextController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 16),
                        hintText: tr("bangladeshi"),
                        hintStyle: const TextStyle(fontSize: 12),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      tr("nid_number"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: provider.nidNumberTextController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 16),
                        hintText: tr("enter_your_nid_number"),
                        hintStyle: const TextStyle(fontSize: 12),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      tr("nid_photocopy"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: provider.nidPhotoCopyImage != null ? true : true,
                      child: InkWell(
                        onTap: () {
                          provider.pickNidImage(context);
                        },
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 0.0,
                            ),
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          child: DottedBorder(
                            color: const Color(0xffC7C7C7),
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(3),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            strokeWidth: 2,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.upload_file,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    tr("add_front_view"),
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        child: provider.nidPhotoCopyPath == null
                            ? CachedNetworkImage(
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                                imageUrl: "${provider.nidPhotoCopyImage}",
                                placeholder: (context, url) => Center(
                                  child: Image.asset(
                                      "assets/images/placeholder_image.png"),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            : Image.file(
                                provider.nidPhotoCopyPath!,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      tr("passport_number"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: const TextStyle(fontSize: 14),
                      controller: provider.passportNumberTextController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 16),
                        hintText: tr("enter_passport_number"),
                        hintStyle: const TextStyle(fontSize: 12),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      tr("passport_photocopy"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible:
                          provider.passportPhotocopyImage != null ? true : true,
                      child: InkWell(
                        onTap: () {
                          provider.pickPassportImage(context);
                        },
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 0.0,
                            ),
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          child: DottedBorder(
                            color: const Color(0xffC7C7C7),
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(3),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            strokeWidth: 2,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.upload_file,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    tr("upload_your_file"),
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        child: provider.passportPhotocopyPath == null
                            ? CachedNetworkImage(
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                                imageUrl: "${provider.passportPhotocopyImage}",
                                placeholder: (context, url) => Center(
                                  child: Image.asset(
                                      "assets/images/placeholder_image.png"),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            : Image.file(
                                provider.passportPhotocopyPath!,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      tr("blood_group"),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Colors.grey, spreadRadius: 1),
                        ],
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text(
                            tr("enter_blood_group"),
                            style: const TextStyle(fontSize: 14),
                          ),
                          value: provider.bloodGroupTypeValue,
                          icon: const Icon(
                            Icons.arrow_downward,
                            size: 20,
                          ),
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (String? newValue) {
                            provider.dropdownMenu(newValue);
                          },
                          items: provider.bloodGroupList?.data?.bloodGroup
                              ?.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          provider.updatePersonalInfo(
                              context,
                              provider.nidPhotoCopyPath,
                              provider.passportPhotocopyPath);
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Text(tr("save"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
