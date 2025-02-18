import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/project_details_model.dart';
import '../../../../../data/model/downloads.dart';
import '../../../download/download_screen.dart';

class AttachmentListWidget extends StatelessWidget {

  const AttachmentListWidget({super.key, this.attachmentImage, this.title, this.createdBy,this.file});

  final String? attachmentImage, title, createdBy;
  final Files? file;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            attachmentImage!,
            height: 38.h,
            width: 30.w,
          ),
          SizedBox(
            width: 12.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? "",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    height: 1.45.h),
              ),
              Text(
                createdBy ?? "",
                style: TextStyle(
                    color: const Color(0xff828282),
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    height: 1.45.h),
              ),
            ],
          ),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
              child: Text(
            '',
            style: TextStyle(
                color: const Color(0xff828282),
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                height: 1.45.h),
          )),
          Expanded(
              child: InkWell(
                onTap: (){
                  Downloads download = Downloads.mapCurrentFileToDownload(file!);
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {return DownloaderScreen(downloads: download, platform: Theme.of(context).platform);}));
                },
                child: Text(
            'Download',
            style: TextStyle(
                  color: const Color(0xff2F80ED),
                  fontWeight: FontWeight.bold,
                  fontSize: 11.sp,
                  height: 1.45.h),
          ),
              )),
        ],
      ),
    );
  }
}
