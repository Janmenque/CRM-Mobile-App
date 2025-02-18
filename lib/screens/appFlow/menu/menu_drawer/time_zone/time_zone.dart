import 'package:flutter/material.dart';
import 'package:hrm_app/utils/res.dart';

class TimeZone extends StatelessWidget {
  const TimeZone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        title: const Text('Time Zone'),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextField(
                      iconData: Icons.location_on_outlined,
                      title: 'Location',
                      hintTitle: 'Dhaka, Bangladesh'),
                  const SizedBox(
                    height: 20,
                  ),
                  const Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: Colors.grey,
                      ),
                      Text(
                        'Time Zone',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  DropdownButton(
                    value: 'One',
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    items: <String>['One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {},
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children:  [
                      Icon(
                        Icons.access_time_outlined,
                        color: Colors.grey,
                      ),
                      Text(
                        'Time',
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('13th April, 2022, 11:21 AM')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Column buildTextField({
    IconData? iconData,
    String? title,
    String? hintTitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          children: [
            Icon(
              iconData,
              color: Colors.grey,
            ),
            Text(title!)
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child:
              TextFormField(decoration: InputDecoration(hintText: hintTitle)),
        )
      ],
    );
  }
}
