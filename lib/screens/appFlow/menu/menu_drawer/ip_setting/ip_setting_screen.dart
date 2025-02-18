import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/utils/res.dart';

class IpSettingScreen extends StatelessWidget {
  const IpSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        title:  Text(tr("IP Settings")),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 30,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      tr("mac_address"),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration:  InputDecoration(
                        hintText: '4.4.4.4',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Text(
                      'IP Address',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration:  InputDecoration(
                        hintText: '4.4.4.4',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child:  Text(tr("save"),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
