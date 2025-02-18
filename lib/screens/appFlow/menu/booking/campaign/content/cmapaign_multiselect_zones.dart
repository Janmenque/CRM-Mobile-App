import 'package:flutter/material.dart';
import 'package:hrm_app/data/model/discount/discount_create_component_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/campaign/provider/create_campaign_provider.dart';

class CampaignMultiselectZones extends StatelessWidget {
  CreateCampaignProvider provider;
  CampaignMultiselectZones({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
            onTap: () {
              showZoneMultiSelectDialog(context, provider.campaignComponentListResponse?.data?.serviceZones ?? [], provider);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Zone',
                    style: TextStyle(color: Colors.black54),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ),
        const SizedBox( height: 6,),
        provider.selectedCampaignZones.isNotEmpty ?
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            "Selected Zones:",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ) : const SizedBox(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            provider.selectedCampaignZones.map((e) => e.name).join(", "),
          ),
        ),
      ],
    );
  }

  void showZoneMultiSelectDialog(BuildContext context, List<DiscountComponent> items, CreateCampaignProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text("Select Zone") ,
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                width: double.maxFinite,
                child: ListView(
                  children: items.map((zone) {
                    return CheckboxListTile(
                      title: Text(zone.name!),
                      value: provider.selectedCampaignZones.any((selected) => selected.id == zone.id),
                      onChanged: (bool? value) {
                        provider.toggleZone(zone);
                        setState(() {});
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
