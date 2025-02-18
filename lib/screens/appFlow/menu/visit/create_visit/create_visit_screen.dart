import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/custom_widgets/custom_buttom.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/create_visit/create_visit_provider.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import '../../../../custom_widgets/custom_title_appbar.dart';

class CreateVisitScreen extends StatelessWidget {
  const CreateVisitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateVisitProvider(),
      child: Consumer<CreateVisitProvider>(
        builder: (context, provider, _) {
          return Scaffold(
                backgroundColor: const Color(0xffF5F6FA),
            appBar: 
       PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child:  CustomTitleAppBar(
          title: "create_visit".tr(),
        ),
      ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(
                               horizontal: 4),
                          child: Text(
                            "create_visit".tr(),
                            style:  TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.sp, color: AppColors.black),
                          ),
                        ),
                           SizedBox(
                          height: 15.h,
                        ),
                          Padding(
                          padding: const EdgeInsets.symmetric(
                               horizontal: 4),
                          child: Text(
                            tr("Date *"),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16), 
                          ),
                        ),
                        InkWell(
                          onTap: () => provider.selectDate(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xffE6E6E7))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${provider.selectedDate.toLocal()}"
                                    .split(' ')[0], style: const TextStyle(color: Color(0xffA4A4A5)),),
                                const Icon(Icons.date_range_outlined, color: Color(0xffA4A4A5),)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                         Padding(
                          padding: const EdgeInsets.symmetric(
                               horizontal: 4),
                          child: Text(
                            tr("employee"),
                            style:  TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.sp, ),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title:
                                Text(provider.officialInfo?.data?.name ?? ""),
                            subtitle: Text(
                                provider.officialInfo?.data?.designation ?? ""),
                            leading: ClipOval(
                              child: CachedNetworkImage(
                                height: 45.h,
                                width: 45.w,
                                fit: BoxFit.cover,
                                imageUrl: "${provider.officialInfo?.data?.avatar}",
                                placeholder: (context, url) => Center(
                                  child: Image.asset("assets/images/placeholder_image.png"),
                                ),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                       
                         Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4),
                          child: Text(
                            tr("title*"),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 3.h,),
                        TextFormField(
                          controller: provider.visitTitleTextController,
                          cursorColor: AppColors.primaryColor,
                          cursorHeight: 25.h,
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          decoration:  InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 14.w),
                            fillColor: Colors.white,
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: tr("give_a_title_to_your_visit"),
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
                    color:  Color(0xffE6E6E7),
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
                        Visibility(
                            visible: provider.titleError != null,
                            child: Text(
                              provider.titleError ?? "",
                              style: const TextStyle(color: Colors.red),
                            )),
                        Visibility(
                            visible: provider.errorMassage != null &&
                                provider.titleError == null,
                            child: Text(
                              provider.errorMassage ?? "",
                              style: const TextStyle(color: Colors.red),
                            )),
                         
                         SizedBox(
                          height: 15.h,
                        ),Padding(
                          padding: const EdgeInsets.symmetric(
                         horizontal: 4),
                          child: Text(
                            tr("description_optional"),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 3.h,),
                        TextFormField(
                          controller: provider.visitDescriptionTextController,
                          maxLines: 3 ,
                          cursorColor: AppColors.primaryColor,
                          cursorHeight: 25.h,
                    
                          keyboardType: TextInputType.name,
                          decoration:  InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: tr("write_a_note"),
                               fillColor: Colors.white,
                            filled: true,
                            hintStyle: const TextStyle(fontSize: 14),
                                 enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: const BorderSide(
                    color:  Color(0xffE6E6E7),
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
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.0, vertical: MediaQuery.of(context).size.height *0.02),
                  child: CustomButton(
                    title: tr("create_visit"),
                    clickButton: () {
                      provider.getCreateVisit(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
