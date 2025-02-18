import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:lottie/lottie.dart';

class CustomDialogEmptyField extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const CustomDialogEmptyField({Key? key, this.title, this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
                'assets/images/empty_box.json',
                height: 100,
                width: 100),
            const SizedBox(height: 10,),
            Text(
              title!,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "$subTitle",
                style: const TextStyle(fontSize: 12, color: Colors.black38),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 140,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 20),
                    backgroundColor: AppColors.colorPrimary,
                    textStyle: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold)),
                child:  Text(
                  tr("try_again"),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialogError extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const CustomDialogError(
      {Key? key,
      this.title = "Error",
      this.subTitle = "Something went wrong,try again"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder_image.png',
                image:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3Tkr-ZeotKoDEpqppCgYzjD2IpB7Yg0dGlEPNDO7IFLlNT_v7FiLIpUP9fy0d9zuIdOQ&usqp=CAU',
                height: 60,
                width: 60,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '$title',
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "$subTitle",
                  style: const TextStyle(fontSize: 12, color: Colors.black38),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  width: 140,
                  height: 35,
                  decoration:  BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(5),
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xFF00CCFF),
                          AppColors.colorPrimary,
                        ],
                        begin: FractionalOffset(3.0, 0.0),
                        end: FractionalOffset(0.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child:  Center(child: Text(tr("try_again"),style: const TextStyle(color: Colors.white),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDialogLateComing extends StatelessWidget {
  final String? title;
  final Function? clickGiveReason;

  const CustomDialogLateComing(
      {Key? key, this.title = "Oops! You're late today!", this.clickGiveReason})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SizedBox(
        height: 275,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              CachedNetworkImage(
                height: 120,
                width: 120,
                fit: BoxFit.cover,
                imageUrl:
                    "https://cdn3.vectorstock.com/i/thumb-large/00/17/emotion-avatar-man-crying-success-vector-7640017.jpg",
                placeholder: (context, url) => Center(
                  child: Image.asset("assets/images/placeholder_image.png"),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '$title',
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 140,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (clickGiveReason != null) clickGiveReason!();
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      backgroundColor: AppColors.colorPrimary,
                      textStyle: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  child: const Text(
                    "Give Reason",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDialogImagePicker extends StatelessWidget {
  final Function? onCameraClick;
  final Function? onGalleryClick;

  const CustomDialogImagePicker(
      {Key? key, this.onCameraClick, this.onGalleryClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SizedBox(
         height: MediaQuery.of(context).size.height * 0.30,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Center(
               child:  Text(
                 "Select Options",
                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
               ),
             ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (onCameraClick != null) onCameraClick!();
                  },
                  child: Column(
                    children: [
                      Lottie.asset("assets/images/ic_camera.json",height: 50,width: 50),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Camera",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    if (onGalleryClick != null) onGalleryClick!();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Column(
                      children: [
                        Lottie.asset("assets/images/ic_gallery.json",height: 50,width: 50),
                        const SizedBox(
                          height: 3,
                        ),
                        const Text(
                          "Gallery",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric( horizontal: 20),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}

class CustomDialogBreak extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Function? onGoBack;
  final Function? ok;

  const CustomDialogBreak(
      {Key? key,
      this.title = "Error",
      this.subTitle = "Something went wrong,try again",
      this.ok,
      this.onGoBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SizedBox(
        height: 235,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder_image.png',
                image:
                    'https://thumbs.gfycat.com/UniqueSizzlingFinwhale-max-1mb.gif',
                height: 60,
                width: 60,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '$title',
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "$subTitle",
                  style: const TextStyle(fontSize: 12, color: Colors.black38),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (onGoBack != null) onGoBack!();
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          backgroundColor: const Color(0xffFE0014),
                          textStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      child: const Text(
                        "End",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (ok != null) ok!();
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          backgroundColor: Colors.green,
                          textStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
