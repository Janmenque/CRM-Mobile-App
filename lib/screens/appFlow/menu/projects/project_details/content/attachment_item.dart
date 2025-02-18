import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/data/model/downloads.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/project_details_model.dart';
import '../../../../download/download_screen.dart';

class AttachmentItem extends StatelessWidget {
  final Files? file;

  const AttachmentItem({Key? key, this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          '${file?.attachment}',
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
              '${file?.title}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  height: 1.45.h),
            ),
            Text(
              '${file?.createdBy}',
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
          onTap: () {
            if (file != null) {
              Downloads download = Downloads.mapCurrentFileToDownload(file!);
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return DownloaderScreen(
                    downloads: download, platform: Theme.of(context).platform);
              }));
            }
          },
          child: Text(
            'Download',
            style: TextStyle(
                color: const Color(0xff2F80ED),
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                height: 1.45.h),
          ),
        )),
      ],
    );
  }
}
