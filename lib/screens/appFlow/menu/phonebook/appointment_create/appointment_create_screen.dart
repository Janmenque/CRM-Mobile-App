import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hrm_app/screens/appFlow/menu/phonebook/appointment_create/appointment_create_provider.dart';
import 'package:provider/provider.dart';

class AppointmentCreateScreen extends StatelessWidget {
  final String? navigation;

  const AppointmentCreateScreen({Key? key, this.id, this.navigation})
      : super(key: key);

  ///user Id
  final int? id;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return ChangeNotifierProvider(
      create: (context) => AppointmentCreateProvider(navigation.toString()),
      child: Consumer<AppointmentCreateProvider>(
        builder: (BuildContext context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title:  Text(tr("appointment_create")),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextTitle(tr("title*")),
                      buildTextFormField(
                          labelTitle: tr("enter_title"),
                          controller: provider.titleController),
                      const SizedBox(
                        height: 25,
                      ),
                      buildTextTitle(tr("description")),
                      TextFormField(
                        controller: provider.descriptionController,
                        maxLines: 3,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          hintText: "Enter Description",
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      buildTextTitle(tr("date_schedule")),
                      Card(
                        child: InkWell(
                          onTap: () => provider.selectDate(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(provider.monthYear ?? tr("date")),
                                const Icon(
                                  Icons.arrow_drop_down_sharp,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(
                                  tr("start_time"),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  child: InkWell(
                                    onTap: () => provider.showTime(context, 0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(provider.startTime ??
                                              tr("start_time")),
                                          const Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(
                                  tr("end_time"),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Card(
                                  child: InkWell(
                                    onTap: () => provider.showTime(context, 1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(provider.endTime ?? tr("end_time")),
                                          const Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      buildTextTitle(tr("Location*")),
                      buildTextFormField(
                          labelTitle: tr("enter_location"),
                          controller: provider.locationController),
                      id == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                buildTextTitle(tr("appointment_with")),
                                Card(
                                  child: ListTile(
                                    onTap: () =>
                                        provider.getAllUserData(context),
                                    title: Text(provider.allUserData?.name! ??
                                        tr("add_a_Substitute")),
                                    subtitle: Text(
                                        provider.allUserData?.designation! ??
                                            tr("add_a_Designation")),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(provider
                                              .allUserData?.avatar! ??
                                          'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png'),
                                    ),
                                    trailing: const Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 25,
                      ),
                       Text(
                        tr("attachment"),
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            style: BorderStyle.solid,
                            width: 0.0,
                          ),
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: InkWell(
                          onTap: () => provider.pickAttachmentImage(context),
                          child: DottedBorder(
                            color: const Color(0xffC7C7C7),
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(3),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 16),
                            strokeWidth: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  [
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
                        height: 6,
                      ),
                      provider.attachmentPath != null
                          ? Image.file(
                              provider.attachmentPath!,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              ///id is for user id
                              await provider.setCreateAppointment(context, id);
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          child:  Text(tr("create"),
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
            ),
          );
        },
      ),
    );
  }

  Padding buildTextTitle(title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  TextFormField buildTextFormField({
    controller,
    labelTitle,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: "$labelTitle",
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return tr("this_field_is_required");
        }
        return null;
      },
    );
  }
}
