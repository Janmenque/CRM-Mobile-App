import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/data/model/reponse_phonebook_details.dart';
import 'package:hrm_app/screens/appFlow/menu/phonebook/appointment_create/appointment_create_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectoryScreen extends StatefulWidget {
  final PhonebookDetailsModel? phonebookDetails;

  const DirectoryScreen({Key? key, this.phonebookDetails}) : super(key: key);

  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> makeMail(String mailAddress) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: mailAddress,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(

        elevation: 0,
        title:  Text(tr("directory"),style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold, fontSize: 16.sp),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            ClipOval(
                child: Image.network(
                  widget.phonebookDetails?.data?.avatar ?? '',
                  height: 150,
                  width: 150,
                )
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.phonebookDetails?.data?.name ?? '',
              style: const TextStyle(
                fontSize: 18,
                height: 1.6,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              widget.phonebookDetails?.data?.designation ?? '',
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                profileMenu(
                    iconData: Icons.call,
                  onPressed: (){
                      _makePhoneCall("tel://${widget.phonebookDetails?.data?.phone}");
                  }

                ),
                profileMenu(iconData: Icons.message),
                profileMenu(
                    iconData: Icons.mail,
                    onPressed: () {
                      makeMail("mailto:${widget.phonebookDetails!.data!.email}}");
                    }),
                profileMenu(
                    iconData: Icons.messenger_outline_outlined),
                profileMenu(
                    iconData: Icons.calendar_today_outlined,
                    onPressed: () => NavUtil.navigateScreen(
                      context,
                      AppointmentCreateScreen(
                        id: widget.phonebookDetails!.data!.id,navigation: "directory",
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            buildProfileDetails(
              title: tr("phone"),
              description:
              widget.phonebookDetails?.data?.phone ?? tr("n/a"),
            ),
            buildProfileDetails(
              title: tr("email"),
              description:
              widget.phonebookDetails?.data?.email ?? tr("n/a"),
            ),
            buildProfileDetails(
              title: tr("department"),
              description:
              widget.phonebookDetails?.data?.designation ?? tr("n/a"),
            ),
            buildProfileDetails(
              title: tr("date_of_birth"),
              description:
              widget.phonebookDetails?.data?.birthDate ?? tr("n/a"),
            ),
            buildProfileDetails(
              title: tr("blood_group"),
              description:
              widget.phonebookDetails?.data?.bloodGroup ??tr("n/a"),
            ),
            buildProfileDetails(
              title: tr("social_media"),
              description:
              widget.phonebookDetails?.data?.facebookLink ??
                  tr("n/a"),
            ),
          ],
        ),
      ),
    );
  }

  CircleAvatar profileMenu({IconData? iconData, Function()? onPressed}) {
    return CircleAvatar(
      backgroundColor: AppColors.colorPrimary,
      child: IconButton(
        icon: Icon(
          iconData,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }

  Container buildProfileDetails({String? title, description}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(title!),
          ),
          Expanded(
            flex: 2,
            child: Text(description),
          )
        ],
      ),
    );
  }
}
