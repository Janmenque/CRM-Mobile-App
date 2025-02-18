import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/notice/create_notice_report/create_notice_report_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';

class CreateNoticeReport extends StatelessWidget {
  const CreateNoticeReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateNoticeReportProvider(),
      child: Consumer<CreateNoticeReportProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              elevation: 0,
              title:  Text("create_notice".tr(), style: TextStyle(color: AppColors.black, fontSize: 16.sp, fontWeight: FontWeight.bold),),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                      padding:
                       const   EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
                      child: const Text(
                        'subject*',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ).tr(),
                    ),
                    TextFormField(
                      controller: provider.subjectTextController,
                      maxLines: 1,
                      keyboardType: TextInputType.name,
                      decoration:  InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "subject".tr(),
                        hintStyle: const TextStyle(fontSize: 14),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this_field_is_required".tr();
                        }
                        return null;
                      },
                    ),
                     Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
                      child: const Text(
                        'Date*',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ).tr(),
                    ),
                    InkWell(
                      onTap: () => provider.selectDate(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${provider.selectedDate.toLocal()}"
                                .split(' ')[0]),
                            const Icon(Icons.date_range_outlined)
                          ],
                        ),
                      ),
                    ),
                     Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
                      child: const Text(
                        'Department*',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ).tr(),
                    ),
                    InkWell(
                      onTap: () {
                        provider.getAllUserData(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, spreadRadius: 1),
                          ],
                        ),
                        child: Row(
                          children:  [
                           const Text(
                              "Select Department",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ).tr(),
                          const  Spacer(),
                          const  Icon(Icons.keyboard_arrow_down)
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                          children: List.generate(
                              provider.userNames.length,
                              (index) => Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF00CCFF),
                                          AppColors.colorPrimary,
                                        ],
                                        begin: FractionalOffset(2.0, 0.0),
                                        end: FractionalOffset(0.0, 1.0),
                                        stops: [0.0, 1.0],
                                        tileMode: TileMode.clamp),
                                  ),
                                  child: Text(
                                    provider.userNames[index],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  )))),
                    ),
                     Padding(
                      padding:
                         const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
                      child: const Text(
                        'Description*',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ).tr(),
                    ),
                    TextField(
                      controller: provider.descriptionTextController,
                      maxLines: 5,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: tr("write_a_note"),
                        hintStyle: const TextStyle(fontSize: 14),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      tr("attachment"),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        provider.pickAttachmentImage(context);
                      },
                      child: Container(
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
                              horizontal: 10, vertical: 14),
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
                      height: 10,
                    ),
                    const SizedBox(height: 12,),
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
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: (){
                        provider.createNoticeApi(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: Text(tr("next"),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
