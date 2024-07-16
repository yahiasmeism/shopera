import 'package:flutter/material.dart';
import '../data/model/setting_item_model.dart';

class SettingItemWidget extends StatelessWidget {
  final SettingItem settingItem;

  const SettingItemWidget({Key? key, required this.settingItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(settingItem.title),
        leading: CircleAvatar(
          backgroundColor: settingItem.backgroundColor,
          child: Icon(settingItem.icon, color: Colors.white),
        ),
        trailing: settingItem.trailing ?? const Icon(Icons.arrow_forward),
        onTap: settingItem.onTap,
      ),
    );
  }
}
