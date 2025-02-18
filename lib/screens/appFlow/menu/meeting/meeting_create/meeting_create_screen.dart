import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/meeting/meeting_create/meeting_create_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import '../../../../custom_widgets/custom_title_appbar.dart';


const String kGoogleApiKey = "YOUR_API_KEY"; // Replace with your API key
//GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class MeetingCreateScreen extends StatelessWidget {
  final int? id;

  const MeetingCreateScreen({Key? key, this.id}) : super(key: key);
  final String googleApiKey = 'AIzaSyBdhSJRJiVOYsiy_wmKI4FKxUap3q1-od8';
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return ChangeNotifierProvider(
      create: (context) => MeetingCreateProvider(),
      child: Consumer<MeetingCreateProvider>(
        builder: (BuildContext context, provider, _) {
          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(56.h),
              child: CustomTitleAppBar(
                title: "create_meeting".tr(),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.sp),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "create_meeting".tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: AppColors.black),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          tr("title*"),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextFormField(
                        controller: provider.titleController,
                        cursorColor: AppColors.primaryColor,
                        cursorHeight: 25.h,
                        maxLines: 1,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 14.w),
                          fillColor: Colors.white,
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: tr("enter_title"),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          hintStyle: const TextStyle(fontSize: 14),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Color(0xffE6E6E7),
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return tr("this_field_is_required");
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          tr("description_optional"),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextFormField(
                        controller: provider.descriptionController,
                        maxLines: 3,
                        cursorColor: AppColors.primaryColor,
                        cursorHeight: 25.h,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: tr("write_a_note"),
                          fillColor: Colors.white,
                          filled: true,
                          hintStyle: const TextStyle(fontSize: 14),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Color(0xffE6E6E7),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      ///Date picker field:-------------------------
                      buildTextTitle('date_schedule'.tr()),
                      Card(
                        child: InkWell(
                          onTap: () => provider.selectDate(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(provider.monthYear ?? 'date'.tr()),
                                const Icon(
                                  Icons.arrow_drop_down_sharp,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      ///Time picker field:-------------------------
                      ///Start and End time
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr("start_time"),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  child: InkWell(
                                    onTap: () => provider.showTime(context, 0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(provider.startTime ??
                                              tr("start_time")),
                                          const Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tr("end_time"),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  child: InkWell(
                                    onTap: () => provider.showTime(context, 1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(provider.endTime ??
                                              tr("end_time")),
                                          const Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          tr("location*"),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      GooglePlaceAutoCompleteTextField(
                        textEditingController: TextEditingController(),
                        googleAPIKey: googleApiKey,
                        inputDecoration: const InputDecoration(
                          hintText: 'Enter Location',
                          border: OutlineInputBorder(),
                        ),
                        debounceTime: 800, // Delay for suggestions
                        //countries: ['us', 'in'],
                        isLatLngRequired: true,
                        getPlaceDetailWithLatLng: (placeDetails) {
                          provider.setSelectedLocation(placeDetails.description ?? "No description");
                        },
                        itemClick: (placeDetails) {
                          provider.setSelectedLocation(placeDetails.description ?? "No description");
                        },
                      ),
                      const SizedBox(height: 10),
                      if (provider.selectedLocation.isNotEmpty)
                        const Text('Selected Location: ',),
                      Text(
                        provider.selectedLocation,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      id == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                buildTextTitle(tr("meeting_with")),
                                Card(
                                  child: ListTile(
                                    onTap: () =>
                                        provider.getAllUserData(context),
                                    title: Text(provider.allUserData?.name! ??
                                        tr("add_a_Substitute")),
                                    subtitle: Text(
                                        provider.allUserData?.designation! ??
                                            tr("add_a_Designation")),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(provider
                                              .allUserData?.avatar! ??
                                          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                                    ),
                                    trailing: const Icon(Icons.edit),
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: Row(
                                      children: List.generate(
                                          provider.userNames.length,
                                          (index) => Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                gradient: const LinearGradient(
                                                    colors: [
                                                      Color(0xFF00CCFF),
                                                      AppColors.colorPrimary,
                                                    ],
                                                    begin: FractionalOffset(
                                                        2.0, 0.0),
                                                    end: FractionalOffset(
                                                        0.0, 1.0),
                                                    stops: [0.0, 1.0],
                                                    tileMode: TileMode.clamp),
                                              ),
                                              child: Text(
                                                provider.userNames[index],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )))),
                                )
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        tr("attachment"),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            style: BorderStyle.solid,
                            width: 0.0,
                          ),
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: InkWell(
                          onTap: () => provider.pickAttachmentImage(context),
                          child: DottedBorder(
                            color: const Color(0xffC7C7C7),
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(3),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 16),
                            strokeWidth: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.upload_file,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  tr("upload_your_file"),
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      provider.attachments.isNotEmpty ?
                      Wrap(
                        children: List.generate(provider.attachments.length, (index){
                          return
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 14, bottom: 14),
                                  child: Image.file(
                                    provider.attachments[index],
                                    height: 60, width: 60, fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  top: -10,
                                  child: InkWell(
                                    onTap: ()=> provider.removeImage(index),
                                    child: Card(
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration:  BoxDecoration(
                                          color:  Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.white.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: const Offset(1, 1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: const Icon(Icons.close, color: Colors.red, size: 10,),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                        }),
                      ) :
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (BuildContext context, int index){
                              return  SizedBox(
                                height: 60,
                                width: 60,
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(14.sp),
                                      margin: const EdgeInsets.only(top: 6),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffF5F5F5),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: const Icon(Icons.photo_camera_back, color: Colors.grey,),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: -3,
                                      child: Card(
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration:  BoxDecoration(
                                            color:  Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white.withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 7,
                                                offset: const Offset(1, 1), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: const Icon(Icons.close, color: Colors.black,size: 10,),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),

                      InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            ///id is for user id
                            await provider.postCreateMeeting(context);
                          }
                        },
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: const LinearGradient(
                                colors: [
                                  AppColors.colorPrimary,
                                  AppColors.colorPrimary,
                                ],
                                begin: FractionalOffset(2.0, 0.0),
                                end: FractionalOffset(0.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: Center(
                              child: Text(
                            tr("create"),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Padding buildTextTitle(title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  TextFormField buildTextFormField({
    controller,
    labelTitle,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "$labelTitle",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return tr("this_field_is_required");
        }
        return null;
      },
    );
  }
}
