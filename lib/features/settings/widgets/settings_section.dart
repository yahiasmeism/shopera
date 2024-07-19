import 'setting_item.dart';
import 'package:flutter/material.dart';
import '../data/model/setting_item_model.dart';

class SettingsSectionWidget extends StatelessWidget {
  final String sectionTitle;
  final List<SettingItem> settingItems;

  const SettingsSectionWidget({
    super.key,
    required this.sectionTitle,
    required this.settingItems,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                sectionTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            ...settingItems
                .map((item) => SettingItemWidget(settingItem: item))
                ,
              
          ],
        ),
      ),
    );
  }
}
