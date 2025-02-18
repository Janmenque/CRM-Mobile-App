import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/purchase/create_invoice.dart';
import 'package:hrm_app/screens/custom_widgets/add_client_textfield.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/utils/res.dart';

class AddPurchase extends StatefulWidget {
  const AddPurchase({Key? key}) : super(key: key);

  @override
  State<AddPurchase> createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
  String dropdownValue = 'Chosse Clients';
  String dropdownValue1 = 'Chosse Products';
  String dropdownValue2 = 'Discount Type';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.h),
        child: const CustomTitleAppBar(
          title: "Add Purchase",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 24.0.h),
          child: Container(
            color: Colors.white,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xffD6D6D6))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        style: const TextStyle(color: Color(0xff8A8A8A)),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>[
                          'Chosse Clients',
                          'McDonald\'s',
                          'Tvs',
                          'Suzuki'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateInvoice(),
                          ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 45.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Text(
                                "Items",
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xffD6D6D6))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue1,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        elevation: 16,
                        style: const TextStyle(color: Color(0xff8A8A8A)),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue1 = newValue!;
                          });
                        },
                        items: <String>[
                          'Chosse Products',
                          'McDonald\'s',
                          'Tvs',
                          'Suzuki'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffEAEAEA)),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6)),
                          child: const TextField(
                            maxLines: 1,
                            cursorColor: Color(0xff5B58FF),
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.calendar_month_outlined),
                                border: InputBorder.none,
                                hintText: "Expaire Date"),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                     const Expanded(child: AddClientTextField(hintText: "Quantity")),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                     const Expanded(
                          child:
                              AddClientTextField(hintText: "Purchase Price")),
                      SizedBox(
                        width: 6.w,
                      ),
                     const Expanded(
                          child: AddClientTextField(hintText: "Selling Price")),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: const Color(0xffD6D6D6))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: dropdownValue2,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              elevation: 16,
                              style: const TextStyle(color: Color(0xff8A8A8A)),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue2 = newValue!;
                                });
                              },
                              items: <String>[
                                'Discount Type',
                                'Eid off',
                                'Puja fest',
                                'Suzuki'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                    const  Expanded(
                          child: AddClientTextField(hintText: "Selling Price")),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5B58FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            minimumSize: Size(double.infinity, 50.h),
                          ),
                          child: Text(
                            "Add",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            minimumSize: Size(double.infinity, 50.h),
                          ),
                          child: Text(
                            "Amount",
                            style: TextStyle(
                                color: const Color(0xff5B58FF),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Text(
                    "Choose Payment method",
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffD6D6D6))),
                    child: ExpansionTile(
                      leading: Container(
                        height: 17.h,
                        width: 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xff8A8A8A),
                            )),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Transform(
                        transform: Matrix4.translationValues(-30, -4.0, 0.0),
                        child: const Text("Cash",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
                      ),
                      children: const [
                        Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: AddClientTextField(
                            hintText: "Amount",
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: AddClientTextField(
                            hintText: "Referance",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffD6D6D6))),
                    child: ExpansionTile(
                      leading: Container(
                        height: 17.h,
                        width: 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xff8A8A8A),
                            )),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Transform(
                        transform: Matrix4.translationValues(-30, -4.0, 0.0),
                        child: const Text("Cheque",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
                      ),
                      children: const [
                        Row(
                          children:  [
                            Expanded(
                              child: Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: AddClientTextField(
                                  hintText: "Cheque No.",
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: AddClientTextField(
                                  hintText: "Referance",
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: AddClientTextField(
                            hintText: "Branch",
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: AddClientTextField(
                            hintText: "Account Holde",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffD6D6D6))),
                    child: ExpansionTile(
                      leading: Container(
                        height: 17.h,
                        width: 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xff8A8A8A),
                            )),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Transform(
                        transform: Matrix4.translationValues(-30, -4.0, 0.0),
                        child: const Text("Bank Payment",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
                      ),
                      children: const [
                         Row(
                          children:  [
                            Expanded(
                              child: Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: AddClientTextField(
                                  hintText: "Cheque No.",
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: AddClientTextField(
                                  hintText: "Referance",
                                ),
                              ),
                            ),
                          ],
                        ),
                         Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: AddClientTextField(
                            hintText: "Bank Name",
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: AddClientTextField(
                            hintText: "Branch",
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: AddClientTextField(
                            hintText: "Account Holde",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffD6D6D6))),
                    child: ExpansionTile(
                      leading: Container(
                        height: 17.h,
                        width: 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xff8A8A8A),
                            )),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Transform(
                        transform: Matrix4.translationValues(-30, -4.0, 0.0),
                        child: const Text("Online Payment",
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff5B58FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      minimumSize: Size(double.infinity, 50.h),
                    ),
                    child: Text(
                      "Add Purchase",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
