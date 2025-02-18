import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/auth/login/login_provider.dart';
import 'package:provider/provider.dart';
import '../../../utils/nav_utail.dart';
import '../../../utils/res.dart';
import '../navigation_bar/buttom_navigation_bar.dart';

class AppPermissionPage extends StatelessWidget {
  const AppPermissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          AppColors.colorPrimary.withOpacity(0.7),
          AppColors.colorPrimary
        ])),
        child: ListView(
          children: [
            const SizedBox(
              height: 32.0,
            ),
            const Text(
              'Turning on location services allows us to provide features like:',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            const SizedBox(
              height: 32.0,
            ),
            const ListTile(
              leading: Icon(
                Icons.add_location,
                color: Colors.white,
                size: 30.0,
              ),
              title: Text(
                'Location data to enable user employee attendance and visit feature',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            const ListTile(
              leading: Icon(
                Icons.local_gas_station_sharp,
                color: Colors.white,
                size: 30.0,
              ),
              title: Text(
                'Find distance between employee and office position for accurate daily attendance',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            const ListTile(
              title: Text(
                'You can change this later in the settings app',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LoginProvider>().checkGps(context);
                NavUtil.replaceScreen(context, const ButtomNavigationBar());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              child: Text(tr("next"),
                  style: const TextStyle(
                    color: AppColors.colorPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
